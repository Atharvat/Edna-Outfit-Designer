import 'package:flutter/material.dart';

class LookScreen extends StatefulWidget {
  const LookScreen({super.key});

  @override
  State<LookScreen> createState() => _LookScreenState();
}

class _LookScreenState extends State<LookScreen> {

  String pageTitle = "Dazzling Velvet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            shadowColor: Colors.black,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(pageTitle,
                      style: const TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.bookmark_add_outlined, size: 24, color: Colors.black,),
                          tooltip: 'Bookmark',
                          onPressed: () {
                            // handle the press
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 24, color: Colors.black,),
                          tooltip: 'Bookmark',
                          onPressed: () {
                            // handle the press
                          },
                        ),
                      ],
                    )
                  ]
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_shopping_cart, size: 24, color: Colors.white,),
        onPressed: () {},
        label: const Text(
          "Add look to cart",
          style: TextStyle(
            color: Colors.white,
          ),),
        backgroundColor: const Color(0xFF038969),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0))
        ),
      ),
      body: Column(
        children: <Widget>[
          const Expanded (
              child: Column(
                children: <Widget>[
                  Text(
                      "sdsd",
                  )
                ],
              )),
          Container(
            height: 80,
            alignment: Alignment.center,
            color: const Color(0x10000000),
            child: const Text("Placeholder for chat window"),
          )
        ],
      ),
    );
  }
}
