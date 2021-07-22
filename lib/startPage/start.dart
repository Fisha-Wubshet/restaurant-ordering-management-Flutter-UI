import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/componets/products.dart';
import 'package:digital_menu_test/main.dart';
import 'package:flutter/material.dart';
class start extends StatefulWidget {
  const start({Key key}) : super(key: key);

  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  orderType='eat in';
                  print(orderType);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage()),
                          (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x80000000),
                          blurRadius: 30.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                         Color(0xffEC2326),
                          Color(0xffEC2326),
                        ],
                      )),
                  child: Center(
                    child: Text(
                      'Eat In',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  orderType='take out';
                  print(orderType);

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage()),
                          (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x80000000),
                          blurRadius: 30.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffEC2326),
                          Color(0xffEC2326),
                        ],
                      )),
                  child: Center(
                    child: Text(
                      'Take Out',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

