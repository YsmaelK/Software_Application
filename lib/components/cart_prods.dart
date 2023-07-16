import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  const Cart_products({Key? key}) : super(key: key);

  @override
  State<Cart_products> createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Lil Yachty",
      "picture": "images/cat/yachty.png",
      "price": 85,
    },
    {
      "name": "Weyes Blood",
      "picture": "images/cat/WB.png",
      "price": 65,
    },

  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length ,
        itemBuilder: (context, index){
          return Single_cart_prod(
            cart_name: Products_on_the_cart[index]["name"],
            cart_picture: Products_on_the_cart[index]["picture"],
            cart_price: Products_on_the_cart[index]["price"],
          );
        });
  }
}

class Single_cart_prod extends StatelessWidget {
  final cart_name;
  final cart_picture;
  final cart_price;

  Single_cart_prod({
    this.cart_name,
    this.cart_picture,
    this.cart_price
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: new Image.asset(cart_picture, width: 80,height: 80,),
        title: new Text(cart_name),

        subtitle: new Container(
          child: new Text("\$${cart_price}"),
        ),
      ),
    );
  }
}

