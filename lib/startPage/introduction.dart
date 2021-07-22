import 'package:digital_menu_test/main.dart';
import 'package:digital_menu_test/startPage/Scan_page.dart';
import 'package:digital_menu_test/startPage/start.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class introduction extends StatefulWidget {
  const introduction({Key key}) : super(key: key);

  @override
  _introductionState createState() => _introductionState();
}

class _introductionState extends State<introduction> {
  @override
  void initState() {
    super.initState();
  }
  String _scanBarcode = 'Unknown';
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print(barcodeScanRes);
    });
    if(barcodeScanRes!='Failed to get platform version.' && barcodeScanRes!='Unknown' ){
      Fluttertoast.showToast(
          msg: "$barcodeScanRes",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  start()),
              (Route<dynamic> route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:Color(0xffEC2326),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Image.asset(
                    "images/Asset10.png",
                    fit: BoxFit.cover
                ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(

                    TextSpan(

                  children: <TextSpan>[

                    TextSpan(text: 'To',  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 20, ),),),
                    TextSpan(text: ' start ordering',  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 25,fontWeight: FontWeight.bold),),),
                    TextSpan(text: ' click',  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 20,),),),
                    TextSpan(text: ' scan button',  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 25,fontWeight: FontWeight.bold),),),
                  ],
                ),textAlign: TextAlign.center),
              ),

                  GestureDetector(
                    onTap: () {
                     scanQR();
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                             'Start Scan',  style: GoogleFonts.fredokaOne(
                                textStyle: TextStyle(color: Color(0xffEC2326),letterSpacing: .5, fontSize: 25,),),),
                          ),
                        ),
                      ),
                    ),


              ],
            ),
          ),
        ),

      ),
    );
  }


  Widget _buildPopupDialog(BuildContext context, result) {
    return new AlertDialog(
      title: Text(result, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 19)),

      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Connect Bluetooth')
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {

            Navigator.of(context).pop();

          },
          child: const Text('Cancel', style: TextStyle(color: Color(0xff82C042), fontWeight: FontWeight.bold),),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok' , style: TextStyle(color: Color(0xff82C042), fontWeight: FontWeight.bold)),
        ),

      ],
    );
  }
}
