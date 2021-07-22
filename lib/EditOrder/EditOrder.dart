import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/utils/httpUrl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class EditOrder extends StatefulWidget {
  const EditOrder({Key key}) : super(key: key);

  @override
  _EditOrderState createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  List Orders = [];
  bool isLoading = false;
  bool timeoutException =false;
  bool socketException = false;
  bool catchException = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < globalOrderId.length; i++)
    {
      this.fetchOrder(globalOrderId[i]);
    }
  }
  fetchOrder(index) async {
    setState(() {
      isLoading = true;
    });
    int timeout=20;
    try
    {
      var urla = Uri.parse("$httpUrl/api/orders/$index");
      var response = await http.get(urla, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }).timeout(Duration(seconds: timeout));
      print(response.body);
      print('-----gaga');
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('-----gaga');
        print(response.body);
        var items = json.decode(response.body);
        setState(() {
          Orders.add(items);
          isLoading = false;
          print('----------------globalOrderItems');
          print(Orders);

        });
      }
      else if(response.statusCode == 401){
        Fluttertoast.showToast(
            msg: "Your Account is Locked",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);

      }
      else {
        setState(() {
          Orders = [];
          isLoading = false;
        });
      }
    }
    on TimeoutException catch (e) {
      print('Timeout Error: $e');
      setState(() {
        isLoading = false;
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
        isLoading = false;

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
        isLoading = false;
        catchException = true;
      });
      Fluttertoast.showToast(
          msg: "error occurred while loading",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    }
  }
  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds:2));
    setState(() {
      for(int i = 0; i < globalOrderId.length; i++)
      {
        this.fetchOrder(i);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title:  Text(
            'Edit Order',
            style: TextStyle(
                color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, top: 16, right: 2),
                child: new ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    primary: false,
                    itemCount: Orders.length,
                    itemBuilder: (context, index) {
                      return getCard(Orders[index]);
                    }),
              ),


            ],
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: new Text("Total:"),
              subtitle: new Text("555252 birr"),
            )),
            Expanded(
              child: new MaterialButton(onPressed: (){

              },
                child: new Text("Add Order", style:TextStyle(color: Colors.white)),
                color: Color(0xffEC2326),),
            )
          ],
        ),
      ),
    );
  }
  Widget getCard(item){
    var name = item['table_no'];
    var eatin_status =item['eatin_status'];
    var payment_method = item['table_no'];
    //==================================
    var eatin_items=[];
    if(item['eatin_items']!=null) {
      eatin_items = json.decode(item['eatin_items']);
    }
    var takeout_items=[];
    if(item['takeout_items']!=null) {
      takeout_items = json.decode(item['takeout_items']);
    }

    print('-----------------------------eatin_items');
    print(eatin_items.length);



    //=====================================

    return Card(
      elevation: 3,
      shadowColor: Color(0x502196F3),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
          title: Column(
            children: [
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Row(
                        children: [
                          Icon(Icons.fastfood_rounded, color:Color(0xffEC2326)),
                          Text('  Order No:  111',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
                        ],
                      ),
                      Text('$eatin_status',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,))


                    ],
                  ),
              if(eatin_items!=null)
                new ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    primary: false,
                    itemCount: eatin_items.length,
                    itemBuilder: (context, index) {
                      return Single_cart_product(
                          cart_prod_name: eatin_items[index]["item_name"],
                          cart_prod_qty: eatin_items[index]["quantity"],
                          cart_prod_price: eatin_items[index]["price"],
                          cart_prod_pricture: eatin_items[index]["item_pic"],
                          index:index,
                          ordertype:'Eatin',
                          notifyParent: refreshList
                          );
                    }),
              if(takeout_items!=null)
              new ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  primary: false,
                  itemCount: takeout_items.length,
                  itemBuilder: (context, index) {
                    return Single_cart_product(
                        cart_prod_name: takeout_items[index]["item_name"],
                        cart_prod_qty: takeout_items[index]["quantity"],
                        cart_prod_price: takeout_items[index]["price"],
                        cart_prod_pricture: takeout_items[index]["item_pic"],
                        index:index,
                        ordertype:'Takeout',
                        notifyParent: refreshList
                    );
                  }),

            ],
          )

        ),
      ),
    );
  }

}
class Single_cart_product extends StatefulWidget {

  final cart_prod_name;
  final cart_prod_pricture;
  final cart_prod_price;
  final cart_prod_qty;
  final index;
  final ordertype;
  final Function() notifyParent;

  Single_cart_product(
      {this.cart_prod_name,
        this.cart_prod_price,
        this.cart_prod_pricture,
        this.cart_prod_qty,
        this.index,
        this.ordertype,
        this.notifyParent,

      });
  @override
  _Single_cart_productState createState() => new _Single_cart_productState();
}
class _Single_cart_productState extends State<Single_cart_product>{
  int _itemCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(()=> _itemCount = widget.cart_prod_qty);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(

        children: [
          Divider(),
          ListTile(
//     ============== LEADING SECTION ============
            leading: new FadeInImage(image: NetworkImage(
              '$httpUrlImage/${widget.cart_prod_pricture}',
            ),placeholder: AssetImage('images/image_placeholder.png'), width: 100.0,
                height: 60.0),
//     ============== TITLE SECTION ============
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(widget.cart_prod_name, style: TextStyle(
                                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                            new Text(widget.ordertype, style: TextStyle(
                                color: Colors.black45, fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                   new Text(
                            "X${widget.cart_prod_qty} ",
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.red
                            ),
                          ),



                    ],
                  ),


            ),


          ),
        ],
      );

  }}


