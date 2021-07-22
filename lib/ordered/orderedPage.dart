import 'package:digital_menu_test/AddOrder/AddOrder.dart';
import 'package:digital_menu_test/EditOrder/EditOrder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class orderedPage extends StatefulWidget {
  const orderedPage({Key key}) : super(key: key);

  @override
  _orderedPageState createState() => _orderedPageState();
}

class _orderedPageState extends State<orderedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Image.asset(
                    "images/OrderinKitchen.png",
                    fit: BoxFit.cover
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text.rich(

                      TextSpan(

                        children: <TextSpan>[

                          TextSpan(text: 'Your orders are in',  style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 20, ),),),
                          TextSpan(text: ' Kitchen',  style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(color: Color(0xffEC2326), letterSpacing: .5,fontSize: 25,fontWeight: FontWeight.bold),),),
                        ],
                      ),textAlign: TextAlign.center),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => new EditOrder()));
                          },
                          child: Container(
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
                                  'My Order',  style: GoogleFonts.fredokaOne(
                                  textStyle: TextStyle(color: Colors.white,letterSpacing: .5, fontSize: 20,),),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => new AddOrder()));
                          },
                          child: Container(
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
                                  'Add Order',  style: GoogleFonts.fredokaOne(
                                  textStyle: TextStyle(color: Colors.white,letterSpacing: .5, fontSize: 20,),),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Align(
                              alignment: Alignment.center,
                            child: Container(
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
                                      'Waiter',  style: GoogleFonts.fredokaOne(
                                      textStyle: TextStyle(color: Colors.white,letterSpacing: .5, fontSize: 20,),),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Container(
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
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
