import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/ordered/orderedPage.dart';
import 'package:digital_menu_test/utils/httpUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  double total=0;
  bool isLoading = false;
  bool timeoutException =false;
  bool socketException = false;
  bool catchException = false;
  List orderEatinList=[];
  List orderTakeoutList=[];
  Ordermethod() async {
    setState(() {
      isLoading = true;
    });
    int timeout=20;
      var url = Uri.parse("$httpUrl/api/orders");
      var response = await http.post(url, headers: {
        'Accept': 'application/json',
      }, body: {
        "eatin_items" :"$eatin_items",
        "takeout_items" : "$takeout_items",
        "table_no" : "$table_no",
      }).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 201) {
        var items = json.decode(response.body);
        print("${response.statusCode}");
        print("${response.body}");
        var orderlist=[];
        orderlist.add(items);
        print(orderlist[0]['id']);
        globalOrderId.add(orderlist[0]['id']);
        setState(() {
          isLoading = false;
        });
        cartProductCount.value=0;
        Fluttertoast.showToast(
            msg: "Successfully Ordered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildSuccessfulPopupDialog(context),
        ).then((exit) {
           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => orderedPage()), (Route<dynamic> route) => false);
        });


      } else {
        print("${response.statusCode}");
        print("${response.body}");
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Order failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
  }
  eatinOrdermethod() async {
    setState(() {
      isLoading = true;
    });
    int timeout=20;
    var url = Uri.parse("$httpUrl/api/orders");
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
    }, body: {
      "eatin_items" :"$eatin_items",
      "takeout_items" : '',
      "table_no" : "$table_no",
    }).timeout(Duration(seconds: timeout));
    print(response.statusCode);
    print("${response.statusCode}");
    print("${response.body}");
    if (response.statusCode == 201) {
      var items = json.decode(response.body);
      print("${response.statusCode}");
      print("${response.body}");
      var orderlist=[];
      orderlist.add(items);
      print(orderlist[0]['id']);
      globalOrderId.add(orderlist[0]['id']);
      setState(() {
        isLoading = false;
      });
      cartProductCount.value=0;
      Fluttertoast.showToast(
          msg: "Successfully Ordered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildSuccessfulPopupDialog(context),
      ).then((exit) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => orderedPage()), (Route<dynamic> route) => false);
      });


    } else {
      print("${response.statusCode}");
      print("${response.body}");
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Order failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
  takeoutOrdermethod() async {
    setState(() {
      isLoading = true;
    });
    int timeout=20;
    var url = Uri.parse("$httpUrl/api/orders");
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
    }, body: {
      "eatin_items" :'',
      "takeout_items" : "$takeout_items",
      "table_no" : "$table_no",
    }).timeout(Duration(seconds: timeout));
    print(response.statusCode);
    if (response.statusCode == 201) {
      var items = json.decode(response.body);
      print("${response.statusCode}");
      print("${response.body}");
      var orderlist=[];
      orderlist.add(items);
      print(orderlist[0]['id']);
      globalOrderId.add(orderlist[0]['id']);
      setState(() {
        isLoading = false;
      });
      cartProductCount.value=0;
      Fluttertoast.showToast(
          msg: "Successfully Ordered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildSuccessfulPopupDialog(context),
      ).then((exit) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => orderedPage()), (Route<dynamic> route) => false);
      });


    } else {
      print("${response.statusCode}");
      print("${response.body}");
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Order failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
  @override
  void initState() {
    super.initState();
    orderEatinListMethod();
    orderTakeoutListMethod();
    totalAmount();
    print(ordersCart);
  }
  totalAmount(){
    total=0;
    for(int i = 0; i < orderEatinList.length; i++){
      total= total+double.tryParse('${json.decode(orderEatinList[i])["quantity"]}')*double.tryParse('${json.decode(orderEatinList[i])["price"]}');
    }
    setState(() {
      print(total);
      total=total;
    });
  }
  //Minus function
  orderEatinListMethod(){
    setState(() {
      orderEatinList=eatin_items;
    });

  }
  orderTakeoutListMethod(){
    setState(() {
      orderTakeoutList=takeout_items;
    });

  }

  Future<Null> refreshList() async{
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds:2));
    setState(() {
      orderEatinListMethod();
      totalAmount();
    });
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(child: const SpinKitCubeGrid(size: 71.0, color: Color(0xffEC2326)));
    }
    if(orderEatinList.length ==0 && orderTakeoutList.length==0){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                "images/NoOrderYet.png",
                fit: BoxFit.cover
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text.rich(

                  TextSpan(

                    children: <TextSpan>[

                      TextSpan(text: 'Your',  style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 20, ),),),

                      TextSpan(text: ' Cart',  style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 20,fontWeight: FontWeight.bold),),),
                      TextSpan(text: ' is',  style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 20, ),),),
                      TextSpan(text: ' Empty',  style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 20,fontWeight: FontWeight.bold),),),
                    ],
                  ),textAlign: TextAlign.center),
            )
          ],
        ),
      );
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(orderEatinList.length!=0)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('__________   Eat In   __________',style:TextStyle(color: Colors.black45)),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, top: 4, right: 2),
                  child: new ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      primary: false,
                      itemCount: orderEatinList.length,
                      itemBuilder: (context, index) {
                        return Single_cart_product(
                          cart_prod_name: json.decode(orderEatinList[index])["item_name"],
                          cart_prod_qty: json.decode(orderEatinList[index])["quantity"],
                          cart_prod_price: json.decode(orderEatinList[index])["price"],
                          cart_prod_pricture: json.decode(orderEatinList[index])["item_pic"],
                            index:index,
                            ordertype:'Eatin',
                            notifyParent: refreshList);
                      }),
                ),
              if(orderTakeoutList.length!=0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('__________   Take Out   __________',style:TextStyle(color: Colors.black45)),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 2, top: 4, right: 2),
                  child: new ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      primary: false,
                      itemCount: orderTakeoutList.length,
                      itemBuilder: (context, index) {
                        return Single_cart_product(
                            cart_prod_name: json.decode(orderTakeoutList[index])["item_name"],
                            cart_prod_qty: json.decode(orderTakeoutList[index])["quantity"],
                            cart_prod_price: json.decode(orderTakeoutList[index])["price"],
                            cart_prod_pricture: json.decode(orderTakeoutList[index])["item_pic"],
                            index:index,
                            ordertype:'Takeout',
                            notifyParent: refreshList);
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
              subtitle: new Text("$total birr"),
            )),
            Expanded(
              child: new MaterialButton(onPressed: (){
                finalOrderClass ordercart = finalOrderClass(eatin_items,takeout_items, table_no);
                String jsonOrdersCart = jsonEncode(ordercart);
                var itemsCart = json.decode(jsonOrdersCart);
                print(itemsCart);
                if(eatin_items.length!=0 && takeout_items.length!=0) {
                    Ordermethod();
                  }
                if(eatin_items.length!=0 && takeout_items.length==0) {
                  eatinOrdermethod();
                }
                if(eatin_items.length==0 && takeout_items.length!=0) {
                  takeoutOrdermethod();
                }
                },
                child: new Text("Checkout", style:TextStyle(color: Colors.white)),
                color: Color(0xffEC2326),),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildSuccessfulPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 2)),

      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                "images/successfulOrder.png",
                fit: BoxFit.cover
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text.rich(

                  TextSpan(

                    children: <TextSpan>[

                      TextSpan(text: 'Successfully',  style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 20, ),),),

                      TextSpan(text: ' ordered',  style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 22,fontWeight: FontWeight.bold),),),
                    ],
                  ),textAlign: TextAlign.center),
            )

          ],
        ),
      ),

      actions: <Widget>[
        new FlatButton(
          onPressed: () {

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => orderedPage()), (Route<dynamic> route) => false);


          },
          child: const Text('Ok', style: TextStyle(color: Color(0xffEC2326), fontWeight: FontWeight.bold),),
        ),

      ],
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
    return Card(
      child: ListTile(
//     ============== LEADING SECTION ============
        leading: new FadeInImage(image: NetworkImage(
          '$httpUrlImage/${widget.cart_prod_pricture}',
        ),placeholder: AssetImage('images/image_placeholder.png'), width: 100.0,
            height: 80.0),
//     ============== TITLE SECTION ============
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(widget.cart_prod_name, style: TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
             InkWell(
                 onTap: () {
                   if(widget.ordertype=='Eatin') {

                    setState(() {
                      eatin_items.remove(eatin_items[widget.index]);
                    });
                    print(eatin_items);
                  }
                   if(widget.ordertype=='Takeout') {
                     setState(() {
                       takeout_items.remove(takeout_items[widget.index]);
                     });
                     print(eatin_items);
                   }
                  widget.notifyParent();
                   setState(() {
                     cartProductCount.value--;
                   });
                 },

               child: Icon(
                    Icons.cancel,
                    size: 20, color: Color(0xffEC2326),
                  ),
             ),

            ],
          ),
        ),
//     ============== SUBTITLE SECTION ============
        subtitle:  new Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //        this section is for the size of the product
                Container(
                  height: 22,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _itemCount!=1? GestureDetector(
                          onTap: (){

                            setState(()=>_itemCount--);
                            if(widget.ordertype=='Eatin') {
                                var map = jsonDecode(eatin_items[widget.index]);
                                map["quantity"] = _itemCount;
                                eatin_items[widget.index] = jsonEncode(map);
                                print(eatin_items);
                              }
                            if(widget.ordertype=='Takeout') {
                              var map = jsonDecode(takeout_items[widget.index]);
                              map["quantity"] = _itemCount;
                              takeout_items[widget.index] = jsonEncode(map);
                              print(eatin_items);
                            }
                            },
                          child: Icon(
                            Icons.remove,
                            size: 15,
                            color: Colors.white,
                          ),
                        ):new Container(),
                        SizedBox(
                          width: 1,
                        ),
                        Text('${_itemCount}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => _itemCount++);
                            if(widget.ordertype=='Eatin') {
                              var map = jsonDecode(eatin_items[widget.index]);
                              map["quantity"] = _itemCount;
                              eatin_items[widget.index] = jsonEncode(map);
                              print(eatin_items);
                            }
                            if(widget.ordertype=='Takeout') {
                              var map = jsonDecode(takeout_items[widget.index]);
                              map["quantity"] = _itemCount;
                              takeout_items[widget.index] = jsonEncode(map);
                              print(eatin_items);
                            }
                          },
                          child: Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                  alignment: Alignment.topLeft,
                  child: new Text(
                    "${double.tryParse(widget.cart_prod_price)*_itemCount} Birr",
                    style: TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.red
                    ),
                  ),
                )

              ],
            ),

      ),
    );
  }

}


