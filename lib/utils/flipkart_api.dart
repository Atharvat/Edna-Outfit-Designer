import 'dart:convert';
import 'package:http/http.dart' as http;

// returns a list of products for a given search query

class ProductDetails{
  final String name;
  final int currentPrice;
  final double rating;
  final String url;
  final String thumbnailUrl;

  ProductDetails({
    required this.name,
    required this.currentPrice,
    required this.rating,
    required this.url,
    required this.thumbnailUrl,
  });
}

Future<List<ProductDetails>?> FlipkartSearch(String searchQuery) async {
  final searchUrl = "https://flipkart-scraper-api.dvishal485.workers.dev/search/${Uri.encodeComponent(searchQuery)}";
  List<ProductDetails> productDetailsList = [];
  try {
    final searchResponse = await http.get(Uri.parse(searchUrl));

    if (searchResponse.statusCode == 200) {
      final searchData = json.decode(searchResponse.body);
      final searchResults = searchData['result'];
      final first5Results = searchResults.take(5).toList();

      for (final result in first5Results) {
        final productLink = result['link'];
        final productLinkWithoutBaseUrl = productLink.replaceFirst("https://www.flipkart.com", "");
        final productUrl = "https://flipkart-scraper-api.dvishal485.workers.dev/product/${Uri.encodeComponent(productLinkWithoutBaseUrl)}";

        final productResponse = await http.get(Uri.parse(productUrl));

        if (productResponse.statusCode == 200) {
          final productData = json.decode(productResponse.body);
          final name = productData['name'];
          final currentPrice = productData['current_price'];
          final rating = productData['rating'];
          final url = productData['share_url'];
          final thumbnailUrls = productData['thumbnails'];
          var firstThumbnailUrl = "";
          if (thumbnailUrls.isNotEmpty) {
            firstThumbnailUrl = thumbnailUrls[0];
            print("Thumbnail URL for ${productData['name']}: $firstThumbnailUrl");
          } else {
            print("No thumbnail found for ${productData['name']}");
          }
          ProductDetails pd = ProductDetails(name: name, currentPrice: currentPrice, rating: rating, url: url, thumbnailUrl: firstThumbnailUrl);
          productDetailsList.add(pd);
        } else {
          print("Failed to fetch product details for product link: $productLink");
        }
      }
    } else {
      print("Failed to fetch search results.");
    }
  } catch (e) {
    print("An error occurred: $e");
    return null;
  }
}
