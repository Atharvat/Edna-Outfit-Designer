import 'dart:ui';

import 'package:edna/widgets/WardrobeProductsHorizontal.dart';
import 'package:flutter/material.dart';
import 'package:edna/widgets/WardrobeArticleCard.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';



class WardrobeArticlesSection extends StatefulWidget {
  final List<int?> articleIds;
  final String name;

  const WardrobeArticlesSection({super.key, required this.articleIds, required this.name});

  @override
  State<WardrobeArticlesSection> createState() => _WardrobeArticlesSectionState();
}

class _WardrobeArticlesSectionState extends State<WardrobeArticlesSection> {

  bool expanded = false;
  late Database db;
  List<Map<String, Object?>>? articles;
  int expandedArticleId = 99;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadData();
    });
  }

  Future<void> loadData() async {
    var dir = await getApplicationDocumentsDirectory();
    db = await databaseFactoryIo.openDatabase(join(dir.path, 'my_database.db'));
    var wrArticlesStore = intMapStoreFactory.store('wardrobe_articles');
    List<Map<String, Object?>> articles1 = [];
    for(var articleId in widget.articleIds) {
      var article = await wrArticlesStore.record(articleId!).get(db);
      articles1.add(article!);
    }

    setState(() {
       articles = articles1;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.name,
            style: const TextStyle(
              fontFamily: 'General Sans',
              fontSize: 14,
              fontVariations: [
                FontVariation("wght", 500),
              ],
              color: Color(0xFF101828),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 136,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              const SizedBox(width: 16,),
              for(var article in articles ?? [])
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if(expandedArticleId == widget.articleIds[articles!.indexOf(article)]) {
                        setState(() {
                          expandedArticleId = 99;
                        });
                      } else {
                        setState(() {
                          expandedArticleId = 99;
                        });
                        setState(() {
                          expandedArticleId = widget.articleIds[articles!.indexOf(article)] as int;
                        });

                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: WardrobeArticleCard(colors: getStringList(article['colors'] as List), greyed: (!(expandedArticleId == widget.articleIds[articles!.indexOf(article)]) && expanded), expanded: expandedArticleId == widget.articleIds[articles!.indexOf(article)], name: article['name'] as String, imageUrl: article['image_url'] as String, productsCount: (article['products'] as List).length,),
                  )
                ),
              const SizedBox(width: 8,),
            ],
          ),
        ),
        if (expandedArticleId != 99) const SizedBox(height: 16,),
        if (expandedArticleId != 99)
          WardrobeProductsHorizontal(articleId : expandedArticleId),
        const SizedBox(height: 32,),
      ],
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

  List<String> getStringList(List list) {
    // create a new list of size same as list
    List<String> newList = List<String>.filled(list.length, "");
    for(int i = 0; i < list.length; i++) {
      newList[i] = list[i].toString();
    }
    return newList;
  }
}
