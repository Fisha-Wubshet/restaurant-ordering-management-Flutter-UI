import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/componets/horizontal_listview.dart';
import 'package:digital_menu_test/main.dart';
import 'package:digital_menu_test/utils/httpUrl.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_test/pages/product_details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  List categories = [];
  List Submenu = [];
  bool isLoadingSubmenu = false;
  bool isLoadingCategories = false;
  bool timeoutException =false;
  bool socketException = false;
  bool catchException = false;
  int selectedIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchCategories();

  }
  fetchCategories() async {
    setState(() {
      isLoadingCategories = true;
    });
    int timeout=20;
    try
    {

      var urla = Uri.parse("$httpUrl/api/categories");
      var response = await http.get(urla, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }).timeout(Duration(seconds: timeout));
      print(response.body);
      if (response.statusCode == 200) {
        var items = json.decode(response.body);
        setState(() {
          categories = items;
          isLoadingCategories = false;
          fetchSubmenu(selectedIndex);
        });
      } else {
        categories = [];
        isLoadingCategories = false;
      }
    }
    on TimeoutException catch (e) {
      print('Timeout Error: $e');
      setState(() {
        isLoadingCategories = false;
        timeoutException = true;
      });
      Fluttertoast.showToast(
          msg: "connection timeout, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    } on SocketException catch (e) {
      print('Socket Error: $e');
      setState(() {
        isLoadingCategories = false;

        socketException = true;
      });
      Fluttertoast.showToast(
          msg: "no connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    } on Error catch (e) {
      print('$e');
      setState(() {
        isLoadingCategories = false;
        catchException = true;
      });
      Fluttertoast.showToast(
          msg: "error occurred while loading",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    }
  }
  fetchSubmenu( int index) async {
    setState(() {
      isLoadingSubmenu = true;
    });
    int timeout=20;
    try
    {
      var url = Uri.parse("$httpUrl/api/showCategory/${categories[index]['id']}");
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }).timeout(Duration(seconds: timeout));
      print(response.body);
      if (response.statusCode == 200) {
        var items = json.decode(response.body);
        setState(() {
          Submenu = items;
          isLoadingSubmenu = false;
        });
      } else {
        Submenu = [];
        isLoadingSubmenu = false;
      }
    }
    on TimeoutException catch (e) {
      print('Timeout Error: $e');
      setState(() {
        isLoadingSubmenu = false;
        timeoutException = true;
      });
      Fluttertoast.showToast(
          msg: "connection timeout, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    } on SocketException catch (e) {
      print('Socket Error: $e');
      setState(() {
        isLoadingSubmenu = false;

        socketException = true;
      });
      Fluttertoast.showToast(
          msg: "no connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    } on Error catch (e) {
      print('$e');
      setState(() {
        isLoadingSubmenu = false;
        catchException = true;
      });
      Fluttertoast.showToast(
          msg: "error occurred while loading",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    }
  }
  @override
  Widget build(BuildContext context) {
    if(categories.contains(null) || categories.length < 0 || isLoadingCategories){
      return Center(child: const SpinKitCubeGrid(size: 71.0, color: Color(0xffEC2326)));
    }
    return  SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Center(
                  child: Container(
                    height: 65,
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = i;
                                      fetchSubmenu(selectedIndex);
                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(

                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x30F44336),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                        color: selectedIndex == i ? Colors.red : Colors.white,
                                        border: Border.all(
                                          color: Colors.red,

                                        ),
                                        borderRadius: BorderRadius.all(

                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                                        child: Center(
                                          child: Text(
                                            categories[i]['cat_name'],
                                            style: TextStyle(fontSize: 20, color:selectedIndex == i ? Colors.white : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                        }),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.forward, )),
              if(isLoadingSubmenu)
    Center(child: const SpinKitCubeGrid(size: 71.0, color: Color(0xffEC2326))),
              if(!isLoadingSubmenu)
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    primary: false,
                  shrinkWrap: true,
                    itemCount: Submenu.length,
                    gridDelegate:
                        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (_) =>
                              new ProductDetails(
                                product_detail_name: Submenu[index]['item_name'],
                                product_detail_price: Submenu[index]['price'],
                                product_detail_id: Submenu[index]['id'],
                                product_detail_picture: Submenu[index]['item_pic'],
                              )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Single_prod(
                            prod_name: Submenu[index]['item_name'],
                            prod_pricture: Submenu[index]['item_pic'],
                            prod_id: Submenu[index]['id'],
                            prod_price: Submenu[index]['price'],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),


    );
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_id;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_id,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
            tag: new Text("hero 1"),

                    child: GridTile(
                        footer: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white70,
                            child: new Row(children: <Widget>[
                              Expanded(
                                child: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                              ),
                              new Text("${prod_price} Birr", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                            ],)
                          ),
                        ),

                          child: Material(

                            elevation: 14,
                            borderRadius: BorderRadius.circular(15.0),
                            shadowColor: Color(0x502196F3),
                            child: ClipRRect(

                              borderRadius: BorderRadius.circular(15.0),
                              child:FadeInImage(image: NetworkImage(
                                  '$httpUrlImage/${prod_pricture}',
                              ),placeholder: AssetImage('images/image_placeholder.png'),  fit: BoxFit.fill)


                            ),
                          ),
                        ),




          );



  }
}
