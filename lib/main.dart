import 'package:digital_menu_test/class/cart_class.dart';
import 'package:digital_menu_test/componets/cart_products.dart';

import 'package:digital_menu_test/ordered/orderedPage.dart';
import 'package:digital_menu_test/request/orderTypeDropdown.dart';
import 'package:digital_menu_test/request/request.dart';
import 'package:digital_menu_test/startPage/introduction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//my own imports
import 'package:digital_menu_test/componets/horizontal_listview.dart';
import 'package:digital_menu_test/componets/products.dart';
import 'package:digital_menu_test/pages/cart.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: introduction()),
  );
}

class HomePage extends StatefulWidget {
  final notifyParent;
  HomePage({this.notifyParent});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedPage = 0;
  var dropdownValue = '$orderType';
  changeOrderType( newValue){
    setState(() {
      dropdownValue = newValue;
      orderType=newValue;
    });
  }

  @override
  void initState() {
    super.initState();
  }
  final _pageOptions = [
    Products(),
    Cart_products(),
  ];

  var _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        title: Text(
          'Digital Menu',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu , size: 35, color: Colors.red,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
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
      drawer: new Drawer(
        child: new ListView(children: <Widget>[
          //           header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),

              // dropdown below..
              child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
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
                      child: Text(value, style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(color: Colors.red, letterSpacing: .5,fontSize: 20, ),),),
                    );
                  }).toList()),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () {
            },
            child: ListTile(
              title: Text('My account'),
              leading: Icon(Icons.person, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new orderedPage()));
            },
            child: ListTile(
              title: Text('My orders'),
              leading: Icon(Icons.shopping_basket, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
            },
            child: ListTile(
              title: Text('cart'),
              leading: Icon(Icons.shopping_cart, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite, color: Colors.red),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About'),
              leading: Icon(Icons.help),
            ),
          ),
        ]),
      ),
      body: PageView(
        children: _pageOptions,
        onPageChanged: (index){
          setState(() {
            selectedPage = index;
          });
        },
        controller: _pageController,
      ),

        bottomNavigationBar: Container(
          height: 40,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,), title: Text('Home',style:TextStyle(color: Colors.white, fontSize: 1))),
              BottomNavigationBarItem(icon:  Icon(Icons.shopping_bag_outlined),title: Text('Home',style:TextStyle(color: Colors.white, fontSize: 1))),
            ],
            selectedItemColor: Color(0xffffffff),
            unselectedItemColor: Colors.white60,
            currentIndex: selectedPage,
            backgroundColor: Colors.red,
            onTap: (index){

              setState(() {
                selectedPage = index;
                _pageController.animateToPage(selectedPage, duration: Duration(milliseconds: 200), curve: Curves.linear);
              });

            },

          ),
        ),
      floatingActionButton: Container(
        height: 90,
        width: 80,
        child: Stack(
          children: [
            Positioned(
              bottom: 15,
              left: 2,
              child: Container(

                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFCFDFD), width: 7),
                    shape: BoxShape.circle),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildrequestPopupDialog(context),
                    );
                  },
                  tooltip: 'increment',
                  child: Icon(
                        Icons.receipt_long_outlined,
                        color: Colors.white,
                      ),

                  elevation: 5,
                ),
              ),
            ),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }






  Widget _buildrequestPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 2)),

      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),

                  // dropdown below..
                  child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          orderType=newValue;
                          Navigator.of(context).pop();
                        });
                      },
                      items: <String>[
                        'eat in',
                        'take out'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(color: Colors.red, letterSpacing: .5,fontSize: 20, ),),),
                        );
                      }).toList()),
                ),
              ),
             Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xffEC2326),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Align(
                              child: Text(
                                'Waiter request',  style: GoogleFonts.fredokaOne(
                                textStyle: TextStyle(color: Colors.white,letterSpacing: .5, fontSize: 20,),),),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xffEC2326),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Bill request',  style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(color: Colors.white,letterSpacing: .5, fontSize: 20,),),),
                        ),
                      ),
                    ),
                  ),
                ),


            ],
          ),
      ),

      actions: <Widget>[
        new FlatButton(
          onPressed: () {

            Navigator.of(context).pop();


          },
          child: const Text('Close', style: TextStyle(color: Color(0xffEC2326), fontWeight: FontWeight.bold),),
        ),

      ],
    );
  }
}
