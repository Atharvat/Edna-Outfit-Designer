import 'dart:convert';
import 'package:http/http.dart' as http;

// returns a list of products for a given search query

class ProductDetails{
  final String name;
  final String price;
  final String rating;
  final String url;
  final String thumbnailUrl;

  ProductDetails({
    required this.name,
    required this.price,
    required this.rating,
    required this.url,
    required this.thumbnailUrl,
  });
}

Future<List<ProductDetails>?> flipkartSearch(String searchQuery) async {
  final searchUrl = "https://flipkart-scraper-api.dvishal485.workers.dev/search/${Uri.encodeComponent(searchQuery)}";
  print("debug: Search URL: $searchUrl");
  List<ProductDetails> productDetailsList = [];
  List<ProductDetails> temp = [];
  try {
    final searchResponse = await http.get(Uri.parse(searchUrl));

    if (searchResponse.statusCode == 200) {
      print("debug: Search response: ${searchResponse.body}");
      final searchData = json.decode(searchResponse.body);
      final searchResults = searchData['result'];

      for (final result in searchResults) {
        // final productLink = result['link'];
        // final productLinkWithoutBaseUrl = productLink.replaceFirst("https://www.flipkart.com/", "");
        String firstThumbnailUrl = "";
        if(result['thumbnail'] != null) {
          firstThumbnailUrl = result['thumbnail'];
          print("debug: Thumbnail URL for ${result['name']}: $firstThumbnailUrl");
        }
        final productUrl = result['query_url'];
        print("debug: Product URL: $productUrl");
        final productResponse = await http.get(Uri.parse(productUrl));

        if (productResponse.statusCode == 200) {
          print("debug: Product response: ${productResponse.body}");
          final productData = json.decode(productResponse.body);
          if(productData['error'] != null) {
            print("debug: Error in fetching product details for product link: $productUrl");
            continue;
          }
          final name = productData['name'].toString();
          final price = productData['current_price'].toString();
          final rating = productData['rating'].toString();
          final url = productData['share_url'].toString();
          final thumbnailUrls = productData['thumbnails'];
          if (firstThumbnailUrl == "") {
            if(thumbnailUrls.length > 0) {
              firstThumbnailUrl = thumbnailUrls[0];
              print("debug: Thumbnail URL for ${productData['name']}: $firstThumbnailUrl");
            } else {
              print("debug: No thumbnail list found for ${productData['name']}");
              firstThumbnailUrl = "https://static-assets-web.flixcart.com/fk-p-linchpin-web/fk-cp-zion/img/error-500_cd3e64.png";
            }
          }
          ProductDetails pd = ProductDetails(name: name, price: price, rating: rating, url: url, thumbnailUrl: firstThumbnailUrl);
          productDetailsList.add(pd);
          print("debug: Product details for ${productData['name']}: $pd");
          if(productDetailsList.length >= 2) {
            return productDetailsList;
          }
        } else {
          print("debug: Failed to fetch product details for product link: $productUrl");
        }
      }
    } else {
      print("debug: Failed to fetch search results.");
    }
  } catch (e) {
    print("debug: An error occurred: $e");
    return null;
  }
  return null;
}
