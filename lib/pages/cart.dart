import 'package:flutter/material.dart';
// my imports -Xmx1536M
import 'package:untitled/components/cart_prods.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text('Shopping Cart'),
        actions: [
          new IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(Icons.location_on_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: new Cart_products(),

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
              title: new Text("Total"),
              subtitle: new Text("\$230"),
            )),
            Expanded(
                child: new MaterialButton(
                    onPressed: () {},
                    child: new Text(
                      "Check Out",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red))
          ],
        ),
      ),
    );
  }
}
