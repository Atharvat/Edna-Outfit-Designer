import 'package:edna/screens/HistoryScreen.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:edna/screens/OnboardingScreen.dart';
import 'package:edna/screens/ChatScreen.dart';
import 'package:edna/screens/SwipeScreen.dart';
import 'package:edna/screens/PreferencesScreen.dart';
import 'package:edna/screens/LookScreen.dart';
import 'package:edna/screens/WardrobeScreen.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var dir = await getApplicationDocumentsDirectory();
  // make sure it exists
  await dir.create(recursive: true);
  var dbPath = join(dir.path, 'my_database.db');
  // var db = await databaseFactoryIo.openDatabase(join(dir.path, 'my_database.db'));

  var wrCategoriesStore = intMapStoreFactory.store('wardrobe_categories');
  var wrProductsStore = intMapStoreFactory.store('wardrobe_products');
  var wrArticlesStore = intMapStoreFactory.store('wardrobe_articles');
  var looksStore = intMapStoreFactory.store('looks');
  var articlesStore = intMapStoreFactory.store('articles');
  var productsStore = intMapStoreFactory.store('products');
  var chatsStore = intMapStoreFactory.store('chats');
  var messagesStore = intMapStoreFactory.store('messages');
  var preferencesStore = intMapStoreFactory.store('preferences');
  var userStore = intMapStoreFactory.store('user');
  var outfitOfTheDayStore = intMapStoreFactory.store('outfit_of_the_day');

  Future<void> readJson(var db) async {
    final String response = await rootBundle.loadString('assets/wardrobe.json');
    final data = await json.decode(response);
    // print(data);
    for (var category in data['Categories']) {
      List<int> articlesIds = [];
      for(var article in category['Articles']) {
        List<int> productIds = [];
        for(var product in article['Products']) {
          var id = await wrProductsStore.add(db, product);
          productIds.add(id);
        }
        var id = await wrArticlesStore.add(db,
          {
            "name": article['name'],
            "products": productIds,
            "colors": article['colors'],
            "image_url": article['image_url'],
          }
        );
        articlesIds.add(id);
      }
      await wrCategoriesStore.add(db,
        {
          "name": category['name'],
          "articles": articlesIds,
        }
      );
    }
  }

  // readJson();

  var db = await databaseFactoryIo.openDatabase(dbPath, version: 1,
      onVersionChanged: (db, oldVersion, newVersion) async {
        if (oldVersion == 0) {
          readJson(db);
        }
      });
  var categories = await wrCategoriesStore.find(db);
  for (var record in categories) {
    print('Key: ${record.key}, Value: ${record.value}');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/wardrobe',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/chat': (context) => const ChatScreen(),
        '/history': (context) => const HistoryScreen(),
        '/swipe': (context) => const SwipeScreen(),
        '/preferences': (context) => const PreferencesScreen(),
        '/look': (context) => const LookScreen(),
        '/wardrobe': (context) => const WardrobeScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF038969)),
        useMaterial3: true,
        fontFamily: 'General Sans'
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}