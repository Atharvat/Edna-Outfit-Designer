import 'dart:convert';
import 'dart:ui';

import 'package:edna/globals/myFonts.dart';
import 'package:edna/widgets/WardrobeArticlesSection.dart';
import 'package:flutter/material.dart';
import 'package:edna/screens/BurgerMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../globals/myColors.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {

  final String _pageTitle = "Your Wardrobe";
  final List<String> _todayArticles = [
    "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80",
    "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80",
    "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80",
    "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80",
    "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80",
  ];
  final String _todayOutfitMessage = "This ensemble offers a blend of casual comfort and nostalgic charm, perfect for a day out with friends or exploring the city.";
  late Database db;
  var wrCategoriesStore = intMapStoreFactory.store('wardrobe_categories');
  List<RecordSnapshot<int, Map<String, Object?>>>? categories;

  @override
  void initState() {
    super.initState();
    // loadData().whenComplete(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadData();
    });
  }

  Future<void> loadData() async {
    var dir = await getApplicationDocumentsDirectory();
    db = await databaseFactoryIo.openDatabase(join(dir.path, 'my_database.db'));
    var categories1 = await wrCategoriesStore.find(db);
    setState(() {
      categories = categories1;
    });
    // print((categories1[0]['articles'] as List)[0]);

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0x15000000),
              offset: Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(
            primary: true,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(_pageTitle,
                          style: const TextStyle(
                            fontFamily: 'Playfair Display',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      //add an image with rounded corners as an icon
                      icon: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: const Image(
                            image: AssetImage('images/gunjan.jpeg'),
                            height: 32,
                            width: 32,
                          )// add an image with 32 height
                      ),
                      tooltip: 'Profile',
                      onPressed: () {
                        // handle the press
                      },
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Outfit of the day",
                  style: MyFonts.serifHeading,
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: 136,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 16,),
                    //for each url in _todayArticles, create an image of height 136 and width 96 and spacing of 16 between them
                    for (var url in _todayArticles)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            url,
                            height: 136,
                            width: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(width: 16,),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "EdnaGPT",
                  style: TextStyle(
                    fontFamily: 'General Sans',
                    fontSize: 14,
                    fontVariations: [
                      FontVariation("wght", 500),
                    ],
                    color: Color(0xFF101828),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                  padding: const EdgeInsets.only(left: 16, right: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F7FB),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x15101828), //New
                                blurRadius: 3.0,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          child: Text(
                            _todayOutfitMessage,
                            style: MyFonts.receivedMessageStyle,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x15101828), //New
                                blurRadius: 8.0,
                                offset: Offset(0, 0))
                          ],
                        ),
                        child: SvgPicture.asset(
                          'images/lower_triangle.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 52),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Gap Analysis", style: MyFonts.serifHeading,),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.grey[600],
                    )
                  ],
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFBAD1FD),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      "Get more out of your current wardrobe by adding a few items",
                      style: MyFonts.serifHeading,
                    ),
                  ),
                )
              ),
              const SizedBox(height: 52),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Articles", style: MyFonts.serifHeading,),
              ),
              const SizedBox(height: 24),

              // if(categories != null)
              for(var category in categories ?? [])
                WardrobeArticlesSection(articleIds: getIntList(category['articles']), name: category.value['name'] as String),

              const SizedBox(height: 96),
            ],
          ),
        ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        elevation: 0,
        backgroundColor: MyColors.green10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0))
        ),
        child: const Icon(
            Icons.add,
            color: MyColors.white20,
            size: 24,
        ),
      )
    );
  }

  List<int> getIntList(List list) {
    // create a new list of size same as list
    List<int> newList = List<int>.filled(list.length, 0);
    for(int i = 0; i < list.length; i++) {
      newList[i] = int.parse(list[i].toString());
    }
    return newList;
  }
}
