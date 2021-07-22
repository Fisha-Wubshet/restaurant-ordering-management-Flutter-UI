import 'dart:convert';

import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/pages/cart.dart';
import 'package:digital_menu_test/utils/httpUrl.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_test/main.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_price;
  final product_detail_id;
  final product_detail_picture;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_price,
      this.product_detail_id,
      this.product_detail_picture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedPage = 0;
  var dropdownValue = '$orderType';
  changeOrderType( newValue){
    setState(() {
      dropdownValue = newValue;
      orderType=newValue;
    });
  }
  int _n = 1;
  void add() {

    setState(() {
      _n++;


    });
  }
  //Minus function
  void minus() {
    setState(() {
      if (_n != 1)
        _n--;
    });
  }
  CustomTimer customTimer = new CustomTimer();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: new AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: InkWell(
             onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=> new HomePage()));},
              child: Text('Detail', style: TextStyle(
                  color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () => Navigator.pop(context,true),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 32.0, top: 11, bottom: 5),
              child: Container(
                height: 40,
                width: 50,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        height: 22,
                        width: 22,
                        child: Center(
                          child:   ValueListenableBuilder(
                            //TODO 2nd: listen playerPointsToAdd
                            valueListenable: cartProductCount,
                            builder: (context, value, widget) {
                              //TODO here you can setState or whatever you need
                              return Text(
                                //TODO e.g.: create condition with playerPointsToAdd's value
                                 value.toString());
                            },
                          ),

                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
                        },
                        child: Icon(Icons.shopping_bag_outlined, size: 29, color: Colors.black,),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
        body: new ListView(
          children: <Widget>[
            Center(
              child: new Container(
                height: 300,
                child: GridTile(
                  child: Container(
                    color: Colors.white,
                    child: FadeInImage(image: NetworkImage(
                  '$httpUrlImage/${widget.product_detail_picture}',
                  ),placeholder: AssetImage('images/image_placeholder.png')),
                  ),
                  footer: new Container(
                    color: Colors.white70,
                    child: ListTile(

                      title: Center(
                        child: new Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        minus();
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                            '$_n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        add();
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ),

                    ),
                  ),
                ),
              ),
            ),
            new Container(
              color: Colors.white70,
             child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                            widget.product_detail_name,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                      RichText(
                        text: TextSpan(children: [

                          TextSpan(
                            text: "${widget.product_detail_price}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' Birr',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
            ),
            Row(
              children: <Widget>[
                //     ====== the size button ======


                  // dropdown below..
               Padding(
                 padding: const EdgeInsets.only(left: 4),
                 child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            orderType=newValue;

                          });
                        },
                        items: <String>[
                          'eat in',
                          'take out'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.grey, ),),);

                        }).toList()),
               ),


                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Comment"),
                              content: new Text("your comment"),
                              actions: <Widget>[
                                new MaterialButton(onPressed: (){
                                  Navigator.of(context).pop(context);
                                },
                                  child: new Text ("close"),)
                              ],
                            );
                          });
                    },
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: new Text("Comment")),
                        Expanded(child: new Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        cartClass ordercart=cartClass(widget.product_detail_name,widget.product_detail_picture, _n, widget.product_detail_price);
                        String jsonOrdersCart = jsonEncode(ordercart);
                        var itemsCart = json.decode(jsonOrdersCart);
                        ordersCart.add(jsonOrdersCart);
                        orderItemsClass order= orderItemsClass(widget.product_detail_name,widget.product_detail_picture,  widget.product_detail_price,widget.product_detail_id,_n,'hhhhhh', '0');
                        String jsonOrders = jsonEncode(order);
                        if(orderType=='eat in') {
                          eatin_items.add(jsonOrders);
                          print(eatin_items);
                        }
                        if(orderType=='take out') {
                          takeout_items.add(jsonOrders);
                          print(takeout_items);
                        }
                        setState(() {
                          cartProductCount.value++;
                          Fluttertoast.showToast(
                              msg: "Successfully added to your ordering cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          Navigator.of(context).pop();
                        });
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0.2,
                      child: new Text("Order now")
                  ),
                ),

              ],
            ),
            Divider(),
            new ListTile(
              title: new Text("Ingredients"),
              subtitle: new Text ("tomatoes, cheese, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
            ),
            Divider(),

 //


//          SIMILAR PRODUCTS SECTION


          ],
        ),
      );

  }






}



