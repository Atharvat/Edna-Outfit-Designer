import 'package:edna/globals/myFonts.dart';
import 'package:edna/screens/BurgerMenu.dart';
import 'package:edna/widgets/Preference.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({super.key});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {

  var preferencesStore = intMapStoreFactory.store('preferences');
  List<RecordSnapshot<int, Map<String, Object?>>>? preferences;
  late Database db;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadData();
    });
  }

  Future<void> loadData() async {
    var dir = await getApplicationDocumentsDirectory();
    db = await databaseFactoryIo.openDatabase(join(dir.path, 'my_database1.db'));
    var preferences1 = await preferencesStore.find(db);
    setState(() {
      preferences = preferences1;
    });
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
                          child: Text("About You",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14,),
                //add a circular image
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: const Image(
                            image: AssetImage('images/gunjan.jpg'),
                            height: 200,
                            width: 200,
                          )// add an image with 32 height
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        "Gunjan Dhanuka",
                        style: MyFonts.serifHeading,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32,),
                Text(
                  "Basic Information",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                Preference(title: "Name", value: "Gunjan Dhanuka"),
                Preference(title: "Gender", value: "Female"),
                Preference(title: "Age", value: "36 years, 8 months"),
                Preference(title: "Hair Style", value: "Wolf Cut"),
                const SizedBox(height: 32,),
                Text(
                  "Overall Traits",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                Preference.withIcon(title: "Skin Color", value: "White", icon: Icons.girl),
                Preference.withIcon(title: "Hair Color", value: "Brown", icon: Icons.color_lens_outlined),
                Preference.withIcon(title: "Weight", value: "72 kgs", icon: Icons.monitor_weight_outlined),
                Preference.withIcon(title: "Height", value: "168 cm | 5 ft 2 inch", icon: Icons.height),
                const SizedBox(height: 32,),
                Text(
                  "Measurements",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                Preference(title: "Head Size", value: "Large"),
                Preference(title: "Shoulders", value: "36 cm"),
                Preference(title: "Bust", value: "38 cm"),
                Preference(title: "Waist", value: "32 cm"),
                Preference(title: "Hips", value: "32 cm"),
                Preference(title: "Thighs", value: "20 cm"),
                Preference(title: "Legs", value: "120 cm"),
                Preference(title: "Feet", value: "25 cm | UK 8"),
              ],
            ),
          )
        ),
    );
  }
}
