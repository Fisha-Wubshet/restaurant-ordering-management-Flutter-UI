import 'package:flutter/material.dart';
class orderTypeDropdown extends StatefulWidget {
  const orderTypeDropdown({Key key}) : super(key: key);

  @override
  _orderTypeDropdownState createState() => _orderTypeDropdownState();
}

class _orderTypeDropdownState extends State<orderTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:new Text ("Test"),
      ),
      body: new Center(
          child: new DropdownButton(items: new List.generate(20, (int index){
            return new DropdownMenuItem(child: new Container(
              child: new Text ("Item#$index"),
              width: 200.0, //200.0 to 100.0
            ));
          })
              , onChanged: null)
      ),
    );
  }
}

