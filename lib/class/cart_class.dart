
import 'dart:async';

import 'package:flutter/material.dart';

final cartProductCount = ValueNotifier<int>(0);
class cartClass {
  String item_name;
  String item_pic;
  int quantity;
  String price;
  cartClass(this.item_name,this.item_pic, this.quantity, this.price);

  Map toJson() => {
    'item_name': item_name,
    'item_pic' : item_pic,
    'quantity': quantity,
    'price': price
  };
}
var ordersCart = [];
class CustomTimer {

  Timer _timer;
  int start = 0;
  StreamController streamController;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    streamController = new StreamController<int>();
    _timer = Timer.periodic(oneSec, (Timer timer) {
      start++;
      streamController.sink.add(start);
      print('start value $start');
    });
  }

  void cancelTimer() {
    streamController.close();
    _timer.cancel();
  }

}
//==================== post orders ===================================

var orderType;

var eatin_items=[];
var takeout_items=[];
var finalOrder=[];
var table_no=2;


class orderItemsClass {
  String item_name;
  String item_pic;
  String price;
  var item_id;
  var quantity;
  String comments;
  var mini_status;
  orderItemsClass(this.item_name, this.item_pic, this.price,this.item_id,this.quantity, this.comments, this.mini_status);

  Map toJson() => {
    'item_name': item_name,
    'item_pic' : item_pic,
    'price': price,
    'item_id': item_id,
    'quantity' : quantity,
    'comments': comments,
    'mini_status': mini_status
  };
}

class finalOrderClass {
  var eatInItems;
  var eatOutItems;
  var table;
  finalOrderClass(this.eatInItems,this.eatOutItems, this.table);

  Map toJson() => {
    'eatin_items': eatInItems,
    'takeout_items': eatOutItems,
    'table_no':table,
  };
}
//====================Add post orders ===================================
var AddOrdereatin_items=[];
var AddOrdertakeout_items=[];
//============================== get orders=================================
var globalOrderId=[];
var globalOrderItems=[];
