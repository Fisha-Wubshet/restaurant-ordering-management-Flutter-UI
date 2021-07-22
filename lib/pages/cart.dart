import 'package:flutter/material.dart';
//my imports
import 'package:digital_menu_test/componets/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title:  Text(
          'Cart',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: new Cart_products(),


    );
  }
}

