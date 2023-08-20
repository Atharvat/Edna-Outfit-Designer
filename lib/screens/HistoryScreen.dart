import 'package:edna/globals/myColors.dart';
import 'package:edna/globals/myFonts.dart';
import 'package:edna/screens/BurgerMenu.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  var chatsStore = intMapStoreFactory.store('chats');
  List<RecordSnapshot<int, Map<String, Object?>>>? chats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadData();
    });
  }

  Future<void> loadData() async {
    var dir = await getApplicationDocumentsDirectory();
    var db = await databaseFactoryIo.openDatabase(join(dir.path, 'my_database2.db'));
    var chats1 = await chatsStore.find(db);
    setState(() {
      chats = chats1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x15000000),
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
              )
            ],
            color: Colors.white,
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            primary: true,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/about_you');
                      },
                      icon: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: const Image(
                            image: AssetImage("images/gunjan.jpg"),
                            height: 48,
                            width: 48,
                          )
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("History",
                          style: MyFonts.serifHeading24,
                        ),
                      ),
                    ),
                    IconButton(
                      //add an image with rounded corners as an icon
                      icon: Icon(Icons.close, size: 24, color: Colors.grey[900],),
                      tooltip: 'Close',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
      body: /*SingleChildScrollView(
          child:*/ Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            Text(
              "Today",
              style: MyFonts.prefSectionHeader,
            ),
            const SizedBox(height: 12,),
            for(var chat in chats ?? [])
              if(chat['date'] as String == "today")
                BurgerItem(
                  icon: dummyIcon,
                  text: chat.value['name'] as String,
                  onClicked: () {},
                ),
            const SizedBox(height: 40,),
            Text(
              "Yesterday",
              style: MyFonts.prefSectionHeader,
            ),
            const SizedBox(height: 12,),
            for(var chat in chats ?? [])
              if(chat['date'] as String == "yesterday")
                BurgerItem(
                  icon: dummyIcon,
                  text: chat.value['name'] as String,
                  onClicked: () {},
                ),
            const SizedBox(height: 40,),
            Text(
              "Last Week",
              style: MyFonts.prefSectionHeader,
            ),
            const SizedBox(height: 12,),
            for(var chat in chats ?? [])
              if(chat['date'] as String == "last week")
                BurgerItem(
                  icon: dummyIcon,
                  text: chat.value['name'] as String,
                  onClicked: () {},
                ),
            const SizedBox(height: 40,),

            const Spacer(),

            BurgerItem(
              icon: const Icon(Icons.support, color: MyColors.black10, size: 14),
              text: "Help and Support",
              onClicked: () {},
              backgroundColor: MyColors.white20,
            ),
          ],
        ),
      ),
    );
  }

  final dummyIcon = const Icon(Icons.add, color: Colors.white, size: 0);
}
