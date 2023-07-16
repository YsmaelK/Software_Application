import 'dart:ffi';
//import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/components/brand.dart';
import 'package:untitled/components/category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/components/product.dart';
import 'package:untitled/login/AuthService.dart';
import 'package:untitled/struct/database_serv.dart';
import 'package:untitled/struct/widgets.dart';
import 'package:untitled/struct/group_title.dart';






class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController quatityController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  final priceConroller = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> category = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory = "test";
  late String _currentBrand;
  File? _image1;
  File? _image2;
  File? _image3;
  ImagePicker picker = ImagePicker();
  bool isLoading = false;

  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  double groupPrice = 0.00;

  @override
  void initState() {
    _getCategories();
    //_getBrands();
    categoriesDropDown = getCategoriesDropdown();
   // _currentCategory = categoriesDropDown[0].value!;


  }
  List<DropdownMenuItem<String>> getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items = [];
    for(DocumentSnapshot category in category){
      items.add(new DropdownMenuItem(child: Text(category['category']),
      value: category['category'],));
    }

    return items;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(Icons.close, color: black,),
        title: Text("Add Product", style: TextStyle(color: black),)
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            isLoading ? CircularProgressIndicator() : Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                     // borderSide: BorderSide(color: grey.withOpacity(0.8), width: 1.0),
                      onPressed: (){
                        _selectImage(ImagePicker().pickImage(source: ImageSource.gallery) as Future<XFile>, 1);
                      },
                      child: _displayChild1()
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(

                      //borderSide: BorderSide(color: grey.withOpacity(0.8), width: 1.0),

                      onPressed: (){

                        _selectImage(ImagePicker().pickImage(source: ImageSource.gallery) as Future<XFile> , 2);
                      },
                      child: _displayChild2()
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(

                     // borderSide: BorderSide(color: grey.withOpacity(0.8), width: 1.0),

                      onPressed: (){
                        _selectImage(ImagePicker().pickImage(source: ImageSource.gallery) as Future<XFile>, 3);
                      },
                      child:  _displayChild3()
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Enter a Name (10 Characters max)', textAlign: TextAlign.center, style: TextStyle(color: Colors.blue,fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    groupName = val;
                  });
                },
                controller: quatityController,
                decoration: InputDecoration(
                  hintText: 'Product name'
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'You Must Enter a Name';
                  }else if(value.length > 10){
                    return 'Product name Cant have more than 10 letters';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    groupPrice = val as double;
                  });
                },
                //initialValue: '0.00',
                controller: priceConroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                    hintText: ''
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'You Must Enter a Name';
                  }else if(value.length > 10){
                    return 'Product name Cant have more than 10 letters';
                  }
                },
              ),
            ),
            Column(
              children: [
                TextButton(
                   onPressed : (){
                     popUpDialog(context);
                   }, 
                    child: Text('add product'))
              ],
            )

            /*Expanded(
                child: ListView.builder(
                  itemCount: category.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(category[index]['category']),
                    );
                  }),
            )*/
            /*Center(
              child: DropdownButton(
                  value: _currentCategory,
                items: categoriesDropDown,
                onChanged: changeSelectedCategory("Test")),
            )*/
          ],
        ),
      ),
    );
  }

  _getCategories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategory();
    print(data.length);
    setState(() {
      category = data;
      print(category.length);
    });
  }

   changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }
  void  _selectImage(Future<XFile> pickImage, int imageNumber) async{

    XFile tempImg = (await pickImage) ;
    File file = File(tempImg.path);

    switch(imageNumber){
      case 1: setState(() => _image1 = file as File?);
      break;
      case 2: setState(() => _image2 = file as File?);
      break;
      case 3: setState(() => _image3 = file as File?);
      break;

    }

  }

  Widget _displayChild1() {
    // file1 = File( _image1!.path );
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0,22.0,8.0,22.0),
        child: new Icon(Icons.add, color: grey),
      );

    }else{
      return Image.file(_image1!, fit: BoxFit.fill,width: double.infinity,);


    }
  }

  Widget _displayChild2() {
    if(_image2 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0,22.0,8.0,22.0),
        child: new Icon(Icons.add, color: grey),
      );

    }else{
      return Image.file(_image2!,  fit: BoxFit.fill,width: double.infinity,);

    }
  }

  Widget _displayChild3() {
    if(_image3 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0,22.0,8.0,22.0),
        child: new Icon(Icons.add, color: grey),
      );

    }else{
      return Image.file(_image3!,  fit: BoxFit.fill,width: double.infinity,);
    }
  }

  void validateAndUpload() async{
    if(_formKey.currentState!.validate()){
      setState(() =>
        isLoading = true
      );
      if(_image1 != null && _image2 != null && _image3 != null){
        String imageUrl1;
        String imageUrl2;
        String imageUrl3;
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture1 = "1${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
        UploadTask  task1 = storage.ref().child(picture1).putFile(_image1!) as UploadTask;
        final String picture2 = "2${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
        UploadTask  task2 = storage.ref().child(picture2).putFile(_image2!) as UploadTask;
        final String picture3 = "3${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
        UploadTask  task3 = storage.ref().child(picture3).putFile(_image3!) as UploadTask;
        TaskSnapshot snapshot1 = await task1.then((snapshot) => snapshot );
        TaskSnapshot snapshot2 = await task2.then((snapshot) => snapshot );

        task3.then((snapshot3) async{
          imageUrl1 = await snapshot1.ref.getDownloadURL();
          imageUrl2 = await snapshot2.ref.getDownloadURL();
          imageUrl3 = await snapshot3.ref.getDownloadURL();
          List<String> imageList = [imageUrl1,imageUrl2,imageUrl3];
          _productService.uploadProduct(
            productName: productNameController.text,
             price: double.parse(priceConroller.text),
            images: imageList,

          );
          _formKey.currentState?.reset();

          setState(() =>
          isLoading = false
          );
          Fluttertoast.showToast(msg: 'Product added');
          Navigator.pop(context);

        });
      }else{
        setState(() =>
        isLoading = false
        );
        Fluttertoast.showToast(msg: 'All the Images must be provided');
      }

    }
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
                          FirebaseAuth.instance.currentUser!.uid, groupName)
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
                      groupName: groupName,
                      groupPrice: groupName,
                      userName: snapshot.data['fullName'], groupId: '',);
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


