import 'package:edna/screens/AboutYouScreen.dart';
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
  var dbPath = join(dir.path, 'my_database1.db');
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
    await outfitOfTheDayStore.add(db, {"name": "White ribbed crop top", "image_url": "oftd_crop_top.jpeg"});
    await outfitOfTheDayStore.add(db, {"name": "Black high-waisted jeans", "image_url": "oftd_jeans.jpeg"});
    await outfitOfTheDayStore.add(db, {"name": "Black leather jacket", "image_url": "oftd_jacket.jpeg"});
    await outfitOfTheDayStore.add(db, {"name": "Black slip-on sneakers", "image_url": "oftd_sneakers.jpeg"});
    await outfitOfTheDayStore.add(db, {"name": "Silver mesh strap watch", "image_url": "oftd_watch.jpeg"});
    await outfitOfTheDayStore.add(db, {"name": "Silver hoop earrings", "image_url": "oftd_earrings.jpeg"});

    await preferencesStore.add(db, {"title": "", "value": ""});

    await chatsStore.add(db, {"name": "Ball Dance Gown", "date": "Today", "messages": []});
    await chatsStore.add(db, {"name": "Goa Trip Dresses", "date": "Today", "messages": []});
    await chatsStore.add(db, {"name": "Friends Birthday Party", "date": "Yesterday", "messages": []});
    await chatsStore.add(db, {"name": "Office Party", "date": "Yesterday", "messages": []});
    await chatsStore.add(db, {"name": "Wedding Dress Ideas", "date": "Last Week", "messages": []});
    await chatsStore.add(db, {"name": "Daily casual outfits", "date": "Last Week", "messages": []});
    await chatsStore.add(db, {"name": "Formal Wear", "date": "Last Week", "messages": []});


  }

  // readJson(db);

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
      initialRoute: '/preferences',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/chat': (context) => const ChatScreen(),
        '/history': (context) => const HistoryScreen(),
        '/swipe': (context) => const SwipeScreen(),
        '/preferences': (context) => const PreferencesScreen(),
        '/look': (context) => const LookScreen(),
        '/wardrobe': (context) => const WardrobeScreen(),
        '/about_you': (context) => const AboutYouScreen(),
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