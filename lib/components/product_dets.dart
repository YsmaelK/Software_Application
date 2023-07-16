import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:untitled/struct/helper.dart';
import 'package:untitled/login/login.dart';
import 'package:untitled/login/AuthService.dart';
import 'package:untitled/struct/database_serv.dart';
import 'package:untitled/struct/widgets.dart';
import 'package:untitled/struct/group_title.dart';
import 'package:untitled/pages/search.dart';
import 'package:untitled/pages/profile.dart';

import 'package:untitled/pages/cart.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_nprice;
  final product_detail_oprice;
  final product_detail_picture;
  final product_location;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_nprice,
      this.product_detail_oprice,
      this.product_detail_picture,
      this.product_location});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text('App'),
        actions: [
          new IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(Icons.location_on_rounded, color: Colors.white),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));},
          ),

        ],
      ),
      body: new ListView(
        children: [
          new Container(
              height: 300.0,
              child: GridTile(
                  child: Container(
                      color: Colors.white70,
                      child: Image.asset(widget.product_detail_picture)),
                  footer: new Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: new Text(
                          widget.product_detail_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        title: new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                  "\$${widget.product_detail_oprice}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough)),
                            ),
                            Expanded(
                                child: new Text(
                                    "\$${widget.product_detail_nprice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)))
                          ],
                        ),
                      )))),

          // ======================= THE FIRST BUTTONS =======================
          Row(
              children: [
                // =================== THE SIZE BUTTON =========================
               /* Expanded(
                    child:MaterialButton(onPressed: (){},
                      color: Colors.white,
                      textColor: Colors.grey,
                        elevation: 0.2,
                      child: Row(
                        children: [
                          Expanded(
                              child: new Text("size"),
                          ),
                          Expanded(
                            child: new Icon(Icons.arrow_drop_down),
                          )
                        ],
                      )
                    )
                ),*/

              ],
            ),
      // OPTIONS BUTTON
      Row(
        children: [
          Expanded(
          child: new ListTile(
              title: new Text("John Smith"),
            //subtitle: new Text(""),

          )
          ),
          Expanded(
              child:MaterialButton(onPressed: (){ popUpDialog(context);},
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        child: new Text("\$85\n4 m."),

                      ),
                      Expanded(
                        child: new Icon(Icons.shopping_cart_checkout_outlined),
                      )
                    ],
                  )
              )
          ),


  ]
      ),
          Row(
              children: [
                Expanded(
                    child: new ListTile(
                      title: new Text("Casey Hernandez"),
                      //subtitle: new Text(""),

                    )
                ),
                Expanded(
                    child:MaterialButton(onPressed: (){},
                        color: Colors.white,
                        textColor: Colors.grey,
                        elevation: 0.2,
                        child: Row(
                          children: [
                            Expanded(
                              child: new Text("\$95\n9 m."),

                            ),
                            Expanded(
                              child: new Icon(Icons.shopping_cart_checkout_outlined),
                            )
                          ],
                        )
                    )
                ),


              ]
          ),

        ],

      ),
    );
  }
  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Send a message:",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                /*children: [
                  _isLoading == true
                      ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                      : TextField(
                    onChanged: (val) {
                      setState(() {
                        groupName = val;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],*/
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    /*if (groupName != "")*/ {
                      setState(() {
                        _isLoading = true;
                      });
                      DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName,
                          FirebaseAuth.instance.currentUser!.uid, widget.product_detail_name)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showSnackbar(
                          context, Colors.green, "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }
  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      groupId: widget.product_detail_name,
                      groupName: widget.product_detail_oprice,
                      userName: snapshot.data['fullName'], groupPrice: '',);
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

}
