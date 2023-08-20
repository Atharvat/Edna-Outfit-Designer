import 'package:flutter/material.dart';

class Prompts {
  static const String initialPrompt = """
  You are an exclusive personal outfit designer.
Your client is a 23 year old female. She likes the colors black and white. She has a pear shaped body and wears tops of size M. She is 175 cm tall. She frequently prefers deep V neck and western wear. You have to create personalized outfits for the client.
I will give you a query like: "Suggest me something to wear on a Goa Trip". Then, you should generate multiple outfit options called "looks". Each look should have different components in it like a shirt, trousers, shoes, watch etc. Each component should only contain one item. Be descriptive in the description of components and mention details such as color, sleeve length etc. These items will be searched on Flipkart (India's leading online shopping website), so generate the outfits keeping this in mind. 
Each look should also have an explanation for why the look works or something about the look. The explanation should have a maximum of 20 words.

The response should be exactly in the following format (json format):

Issues: Mention any issues with the prompt if any (eg: The search query is gibberish)

Look 1 -
1. Shirt: Light blue linen shirt
2. Shorts: Khaki chino shorts
3. Hat: Straw fedora
4. Sandals: Brown leather sandals
Explanation: A relaxed and breezy look perfect for exploring Goa. The light colors will keep you cool in the tropical climate.

Look 2 -
...


You have to generate at least 5 looks.

In each look, first list the fields that are present in that look in the JSON itself, and then list the key-value pairs. Something like this (but in JSON formatting for easier copy):-

{"Look 1" : {
items: ['shirt', 'pant'],
'shirt': 'black shirt with long sleeves',
'pant': 'white chinos'}}...

Your response should be exactly according to the format provided (in JSON format), nothing more nothing less. This is very important!

Are you ready to be a personal outfit designer?
  """;

  static const String gapAnalysisPrompt = """
  You are an exclusive personal outfit designer.
Your client is a 23 year old female. She likes the colors black and white. She has a pear shaped body and wears tops of size M. She is 175 cm tall. She frequently prefers deep V neck and western wear. You have to create personalized outfits for the client. I may also provide a list of the wardrobe items of the client, and you will have to suggest the best possible outfits from amongst those wardrobe items.
I will give you a query like: "Suggest me something to wear on a Goa Trip". Then, you should generate multiple outfit options called "looks". Each look should have different components in it like a shirt, trousers, shoes, watch etc. Each component should only contain one item. Be descriptive in the description of components and mention details such as color, sleeve length etc. These items will be searched on Flipkart (India's leading online shopping website), so generate the outfits keeping this in mind. 
Each look should also have an explanation for why the look works or something about the look. The explanation should have a maximum of 20 words.

The response should be exactly in the following format (json format):

Issues: Mention any issues with the prompt if any (eg: The search query is gibberish)

Look 1 -
1. Shirt: Light blue linen shirt
2. Shorts: Khaki chino shorts
3. Hat: Straw fedora
4. Sandals: Brown leather sandals
Explanation: A relaxed and breezy look perfect for exploring Goa. The light colors will keep you cool in the tropical climate.

Look 2 -
...


You have to generate at least 5 looks.

When you get a message followed by "Admin:" consider it as an instruction and not a message from client.

In each look, first list the fields that are present in that look in the JSON itself, and then list the key-value pairs. Something like this (but in JSON formatting for easier copy):-

{"Look 1" : {
items: ['shirt', 'pant'],
'shirt': 'black shirt with long sleeves',
'pant': 'white chinos'}}...

Your response should be exactly according to the format provided (in JSON format), nothing more nothing less. This is very important!

Are you ready to be a personal outfit designer?
  """;
  static const String gapAnalysisPrompt2 = """
  Admin: Here is the wardrobe in JSON format:

{
  "Categories": [
    {
      "name": "Tops",
      "Articles": [
        {
          "name": "T-Shirts",
          "colors": ["#FFFFFF", "#000000", "#008000"],
          "image_url": "tshirts.jpeg",
          "Products": [
            { "text": "Plain white t-shirt", "colors": ["#FFFFFF"] },
            { "text": "Plain black t-shirt", "colors": ["#000000"] },
            { "text": "Printed green t-shirt", "colors": ["#008000"] }
          ]
        },
        {
          "name": "Shirts",
          "colors": ["#0000FF", "#FFFFFF"],
          "image_url": "shirts.jpg",
          "Products": [
            { "text": "Blue formal striped shirt", "colors": ["#0000FF"] },
            { "text": "White button-down shirt with roll-up sleeves", "colors": ["#FFFFFF"] }
          ]
        },
        {
          "name": "Crop Tops",
          "colors": ["#000000", "#FFFFFF"],
          "image_url": "crop-tops.jpg",
          "Products": [
            { "text": "Black crop top with floral pattern", "colors": ["#000000"] },
            { "text": "White ribbed crop top", "colors": ["#FFFFFF"] }
          ]
        },
        {
          "name": "Tank Tops",
          "colors": ["#000080", "#808080"],
          "image_url": "tank-tops.jpg",
          "Products": [
            { "text": "Navy blue tank top with lace trim", "colors": ["#000080"] },
            { "text": "Gray tank top with racerback", "colors": ["#808080"] }
          ]
        }
      ]
    },
    {
      "name": "Traditional Attire",
      "Articles": [
        {
          "name": "Sarees",
          "colors": ["#FF0000", "#0000FF", "#FFD700"],
          "image_url": "sarees.jpg",
          "Products": [
            { "text": "Red silk saree with gold border", "colors": ["#FF0000", "#FFD700"] },
            { "text": "Blue georgette saree with sequin work", "colors": ["#0000FF", "#FFD700"] }
          ]
        },
        {
          "name": "Kurtas",
          "colors": ["#FFFFFF", "#FFD700", "#FF0000", "#00FF00", "#0000FF"],
          "image_url": "kurtas.jpg",
          "Products": [
            { "text": "White kurta with colorful embroidery", "colors": ["#FFFFFF", "#FF0000", "#00FF00", "#0000FF"] },
            { "text": "Peach anarkali kurta with mirror work", "colors": ["#FFD700", "#FF69B4"] }
          ]
        },
        {
          "name": "Salwar Kameez",
          "colors": ["#FFB6C1", "#000080", "#00FF00", "#C0C0C0"],
          "image_url": "salwar-kameez.jpg",
          "Products": [
            { "text": "Light pink salwar kameez set with floral print", "colors": ["#FFB6C1", "#00FF00"] },
            { "text": "Navy blue churidar suit with silver accents", "colors": ["#000080", "#C0C0C0"] }
          ]
        }
      ]
    },
    {
      "name": "Bottoms",
      "Articles": [
        {
          "name": "Jeans",
          "colors": ["#00008B", "#FF4500", "#000000"],
          "image_url": "jeans.jpg",
          "Products": [
            { "text": "Dark wash skinny jeans", "colors": ["#00008B"] },
            { "text": "Distressed boyfriend jeans", "colors": ["#FF4500"] },
            { "text": "Black high-waisted jeans", "colors": ["#000000"] }
          ]
        },
        {
          "name": "Trousers",
          "colors": ["#F5DEB3", "#000000"],
          "image_url": "trousers.jpg",
          "Products": [
            { "text": "Beige tailored trousers", "colors": ["#F5DEB3"] },
            { "text": "Black wide-leg trousers", "colors": ["#000000"] }
          ]
        },
        {
          "name": "Skirts",
          "colors": ["#FF1493", "#000000", "#00FF00", "#FFFF00"],
          "image_url": "skirts.jpg",
          "Products": [
            { "text": "Floral midi skirt", "colors": ["#FF1493", "#00FF00", "#FFFF00"] },
            { "text": "Black pleated mini skirt", "colors": ["#000000"] }
          ]
        },
        {
          "name": "Palazzos",
          "colors": ["#000080", "#FFFFFF", "#800080", "#00FF00", "#FFFF00", "#0000FF"],
          "image_url": "palazzos.jpg",
          "Products": [
            { "text": "Navy blue palazzo pants with white stripes", "colors": ["#000080", "#FFFFFF"] },
            { "text": "Printed palazzos with abstract design", "colors": ["#800080", "#00FF00", "#FFFF00", "#0000FF"] }
          ]
        }
      ]
    },
    {
      "name": "Dresses",
      "Articles": [
        {
          "name": "Midi Dresses",
          "colors": ["#800000", "#FFD700", "#000000"],
          "image_url": "midi.jpg",
          "Products": [
            { "text": "Burgundy wrap-style midi dress", "colors": ["#800000", "#FFD700"] },
            { "text": "Polka dot midi dress", "colors": ["#FFD700", "#000000"] }
          ]
        },
        {
          "name": "Maxi Dresses",
          "colors": ["#008000", "#000000", "#FF69B4"],
          "image_url": "maxi.jpg",
          "Products": [
            { "text": "Flowy floral maxi dress", "colors": ["#008000", "#FF69B4"] },
            { "text": "Solid black maxi dress with side slit", "colors": ["#000000"] }
          ]
        },
        {
          "name": "A-Line Dresses",
          "colors": ["#000080", "#FFFFFF"],
          "image_url": "a-line.jpg",
          "Products": [
            { "text": "Navy blue A-line dress with lace detail", "colors": ["#000080", "#FFFFFF"] },
            { "text": "White summer A-line dress", "colors": ["#FFFFFF"] }
          ]
        }
      ]
    },
    {
      "name": "Outerwear",
      "Articles": [
        {
          "name": "Jackets",
          "colors": ["#000000", "#000080", "#800000", "#FFD700"],
          "image_url": "jackets.jpg",
          "Products": [
            { "text": "Black leather moto jacket", "colors": ["#000000", "#800000"] },
            { "text": "Denim jacket with embroidery", "colors": ["#000080", "#FFD700"] }
          ]
        },
        {
          "name": "Blazers",
          "colors": ["#000080", "#0000FF", "#808080", "#000000"],
          "image_url": "blazers.jpg",
          "Products": [
            { "text": "Navy blue fitted blazer", "colors": ["#000080", "#0000FF"] },
            { "text": "Gray checked blazer", "colors": ["#808080", "#000000"] }
          ]
        },
        {
          "name": "Cardigans",
          "colors": ["#F5DEB3", "#800000", "#FFD700", "#FF69B4"],
          "image_url": "cardigans.jpg",
          "Products": [
            { "text": "Beige longline cardigan", "colors": ["#F5DEB3", "#FFD700"] },
            { "text": "Chunky knit cardigan in maroon", "colors": ["#800000", "#FF69B4"] }
          ]
        }
      ]
    },
    {
      "name": "Footwear",
      "Articles": [
        {
          "name": "Sneakers",
          "colors": ["#FFFFFF", "#000000", "#FFD700", "#00FF00", "#FF69B4"],
          "image_url": "sneakers.jpg",
          "Products": [
            { "text": "White sneakers with pastel accents", "colors": ["#FFFFFF", "#FFD700", "#00FF00", "#FF69B4"] },
            { "text": "Black slip-on sneakers", "colors": ["#000000"] }
          ]
        },
        {
          "name": "Flats",
          "colors": ["#FFD700", "#FF69B4", "#C0C0C0"],
          "image_url": "flats.jpg",
          "Products": [
            { "text": "Nude ballet flats", "colors": ["#FFD700", "#FF69B4", "#C0C0C0"] },
            { "text": "Metallic silver pointed-toe flats", "colors": ["#C0C0C0"] }
          ]
        },
        {
          "name": "Heels",
          "colors": ["#000000", "#FFD700", "#C0C0C0"],
          "image_url": "heels.jpg",
          "Products": [
            { "text": "Black stiletto heels", "colors": ["#000000", "#FFD700"] },
            { "text": "Nude block-heel sandals", "colors": ["#FFD700", "#C0C0C0"] }
          ]
        },
        {
          "name": "Ethnic",
          "colors": ["#FFD700", "#FF69B4", "#C0C0C0"],
          "image_url": "ethnic.jpg",
          "Products": [
            { "text": "Embellished juttis", "colors": ["#FFD700", "#FF69B4", "#C0C0C0"] },
            { "text": "Gold kolhapuri sandals", "colors": ["#FFD700", "#C0C0C0"] }
          ]
        }
      ]
    },
    {
      "name": "Accessories",
      "Articles": [
        {
          "name": "Watches",
          "colors": ["#FF69B4", "#C0C0C0"],
          "image_url": "watches.jpg",
          "Products": [
            { "text": "Rose gold link bracelet watch", "colors": ["#FF69B4", "#C0C0C0"] },
            { "text": "Silver mesh strap watch", "colors": ["#C0C0C0"] }
          ]
        },
        {
          "name": "Bags",
          "colors": ["#000000", "#C0C0C0", "#FFD700"],
          "image_url": "bags.jpg",
          "Products": [
            { "text": "Black leather tote bag", "colors": ["#000000", "#C0C0C0"] },
            { "text": "Embroidered clutch", "colors": ["#FFD700", "#C0C0C0"] }
          ]
        },
        {
          "name": "Jewelry",
          "colors": ["#C0C0C0", "#00FF00", "#FF69B4", "#FFFF00"],
          "image_url": "jewelry.jpg",
          "Products": [
            { "text": "Silver hoop earrings", "colors": ["#C0C0C0"] },
            { "text": "Statement necklace with colored stones", "colors": ["#00FF00", "#FF69B4", "#FFFF00"] }
          ]
        },
        {
          "name": "Scarves",
          "colors": ["#FFD700", "#00FF00", "#FFFF00", "#FF69B4", "#C0C0C0"],
          "image_url": "scarf.jpg",
          "Products": [
            { "text": "Lightweight floral print scarf", "colors": ["#FFD700", "#00FF00", "#FFFF00", "#FF69B4"] },
            { "text": "Solid pashmina shawl", "colors": ["#C0C0C0"] }
          ]
        },
        {
          "name": "Sunglasses",
          "colors": ["#000000", "#C0C0C0", "#FFD700"],
          "image_url": "sunglasses.jpg",
          "Products": [
            { "text": "Oversized black sunglasses", "colors": ["#000000", "#C0C0C0"] },
            { "text": "Tortoiseshell cat-eye sunglasses", "colors": ["#FFD700", "#C0C0C0"] }
          ]
        }
      ]
    }
  ]
}
""";

}


