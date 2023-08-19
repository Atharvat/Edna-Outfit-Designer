import 'dart:ui';

import 'package:edna/widgets/WardrobeProductCard.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class WardrobeProductsHorizontal extends StatefulWidget {
  final int articleId;

  const WardrobeProductsHorizontal({super.key, required this.articleId});

  @override
  State<WardrobeProductsHorizontal> createState() => _WardrobeProductsHorizontalState();
}

class _WardrobeProductsHorizontalState extends State<WardrobeProductsHorizontal> {

  late Database db;
  List<Map<String, Object?>>? products;

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
    var wrProductsStore = intMapStoreFactory.store('wardrobe_products');

    var article = await wrArticlesStore.record(widget.articleId).get(db);
    List<Map<String, Object?>> products1 = [];
    for(var productId in getIntList(article!['products'] as List)) {
      var product = await wrProductsStore.record(productId).get(db);
      products1.add(product!);
    }

    setState(() {
      products = products1;
    });
  }


  @override
  Widget build(BuildContext context) {
    loadData();

    return SizedBox(
      height: 136,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const SizedBox(width: 16,),
          for(var product in products ?? [])
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: WardrobeProductCard(product: product,),
            ),
          const SizedBox(width: 8,),
        ],
      ),
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
