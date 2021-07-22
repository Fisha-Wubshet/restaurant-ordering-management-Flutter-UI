import 'package:digital_menu_test/AddOrder/AddOrderCart.dart';
import 'package:digital_menu_test/AddOrder/AddOrdermenu.dart';
import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/componets/products.dart';
import 'package:flutter/material.dart';
class AddOrder extends StatefulWidget {
  const AddOrder({Key key}) : super(key: key);

  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            title:  Text(
              'Menu',
              style: TextStyle(
                  color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          actions: [
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => new AddOrderCart()));
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
        body: AddOrderMenu());
  }
}
