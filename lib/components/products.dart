
import 'package:flutter/material.dart';
import 'package:untitled/components/product_dets.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Lil Yachty",
      "picture": "images/cat/yachty.png",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Weyes Blood",
      "picture": "images/cat/WB.png",
      "old_price": 100,
      "price": 65,
    },
    {
      "name": "Lakers",
      "picture": "images/cat/Lakers.png",
      "old_price": 200,
      "price": 100,
    },
    {
      "name": "Beyond",
      "picture": "images/cat/wonder.jpg",
      "old_price": 480,
      "price": 400,
    },
    {
      "name": "Kings",
      "picture": "images/cat/kings.jpg",
      "old_price": 80,
      "price": 50,
    },
    {
      "name": "Drake",
      "picture": "images/cat/drake.jpg",
      "old_price": 200,
      "price": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
            tag: prod_name,
            child: Material(
              child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new ProductDetails(
                      product_detail_name: prod_name,
                      product_detail_nprice: prod_price,
                      product_detail_oprice: prod_old_price,
                      product_detail_picture: prod_picture,
                    ))),
                child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Text(
                          prod_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text("\$$prod_price",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w800)),
                        subtitle: Text(
                          "\$$prod_old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ),
                    child: Image.asset(
                      prod_picture,
                      fit: BoxFit.cover,
                    )),
              ),
            )));
  }
}
