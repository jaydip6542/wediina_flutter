import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_appwithapi/filter/finalpage.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:wediina_bussniss/filter/finalpage.dart';

class filterdatedemodemo extends StatefulWidget {
  final String postId;


  filterdatedemodemo({Key key, this.postId, }) : super(key: key);

  filterdatedemodemoState createState() => filterdatedemodemoState();
}



class filterdatedemodemoState extends State<filterdatedemodemo> {
  String dropdownValue = 'Rajkot';

  // To show Selected Item in Text.
  String holder = '' ;

  List <String> actorsName = [

        'Rajkot',
    'Ahmedabad',

  ] ;

  void getDropDownItem(){

    setState(() {
      holder = dropdownValue ;
    });
  }


  String _date = "Not set";
  TextEditingController dateController ;

  //  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
//  final timeFormat = DateFormat("h:mm a");
//
//  signIn(String date) async {
//    String postId;
//    print(date);
//    print(widget.postId);
//    Map data={
//      'vendor_cat_id': widget.postId,
//      'booking_date': date,///
//    };
//    //  var jsonData = null;
//    var response = await http.post('https://api-wediina.herokuapp.com/vendorDatefilter', body: data);
//    final posts = json.decode(response.body);
//    print(posts);
////    setState((){
////      Navigator.of(context).push(
////        MaterialPageRoute(
////          builder: (context) => Vendorpages(),
////        ),
////      );
////
////    }
////    );
//  }
  String id;










  DateTime date = new DateTime.now();

  // TimeOfDay time;

  Future<Null> selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        builder: (context, child)
        {
          return SingleChildScrollView(child: child,);
        }
    );

    //  String _formattedate = new DateFormat.yMMMd().format(date);

    if(_seldate!=null){
      setState(() {
        date = _seldate;
        var formatter = new DateFormat('dd/MM/yyyy');
        String formatted = formatter.format(date);
        dateController = new TextEditingController(text: formatted);
      });
    }
  }

  @override
  void initState() {
    super.initState();

  }






  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMd().format(date);

    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        title: Text('filter page'),
        backgroundColor: Colors.redAccent[200],
      ),



      body:
      Column  (
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(top: 40),
           child: Stack(
            children: <Widget>[
                      Container(
                        margin: new EdgeInsets.only(left: 280.0,right: 20),
                        child: IconButton(

                          onPressed: () {
                            selectdate(context);
                          },
                          icon: Icon(Icons.today),
                        ),
                      ),

                       Container(
                        height: 50,
                        margin: new EdgeInsets.only(left: 30.0,right: 20),
                        child:
                        TextFormField(
                          enabled: false,
                          controller: dateController,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(
                              color: Colors.black, fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),

                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Mobile No is required';
                            }
                          },
                        ),
                      ),
          ],
      ),
          ),




          Container(
            margin: EdgeInsets.only(left: 50.0,top:30.0,right: 50),

            child: DropdownButton<String>(

              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              //elevation: 16,

              style: TextStyle(color: Colors.red, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.redAccent,
              ),
              onChanged: (String data) {
                //print(dropdownValue);
                setState(() {
                  dropdownValue = data;
                });
              },
              items: actorsName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),


          Container(
//            height: 70,
//          width:50,
            margin: EdgeInsets.only(top:20.0),
            alignment: Alignment.center,
            child: RaisedButton(
       onPressed:() => _navigateToPost(context, widget.postId, dateController.text , dropdownValue),
              textColor: Colors.white,

              color: Colors.redAccent[100],
              padding: const EdgeInsets.all(8.0),
              splashColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text('Apply'),
            ),
          ),













        ],
      ),

    );
  }


  void _navigateToPost(BuildContext context, String postId ,String dateController,String dropdownValue) {
    print(postId);
    print(dateController);
    print(dropdownValue);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Filterdateresultedemo(postId: postId, Value:dateController, DaTa:dropdownValue ),
      ),
    );
  }


}
