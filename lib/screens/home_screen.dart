import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aara_task/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final url =
      "https://zzzmart.com/admin/ecommerce_api/category/cat_read.php?apicall=category_list";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");

    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
    final decodedData = jsonDecode(catalogJson);
    final productsData = decodedData[0];
    final data = productsData["data"];
    CatalogModel.items =
        List.from(data).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(
          Icons.dehaze_rounded,
          color: Colors.indigo,
          size: 30,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {},
            color: Colors.indigo,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        iconSize: 40,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),

          ///Booking
          BottomNavigationBarItem(
              icon: Icon(
                Icons.storefront_outlined,
                color: Colors.grey,
              ),
              label: 'Bookings',
              tooltip: "Bookings"),

          ///Favourite
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
            label: 'Favourite',
          ),

          ///Accounts
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              color: Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
            padding: EdgeInsets.all(30),
            itemCount: CatalogModel.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
            ),
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return SizedBox(
                child: MaterialButton(
                  height: 300,
                  color: Colors.white,
                  elevation: 7,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 0,
                      left: 0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              catalog.image.toString(),
                              height: 80,
                              width: 100,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  catalog.name,
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                  "short description",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.favorite),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("100"),
                            Text("100"),
                            Icon(Icons.shopping_cart),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
