import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_appwithapi/loginsingup/custmorlogin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Vendor_Inquery extends StatefulWidget {
  final String postId;

  final String Email;
  const Vendor_Inquery({Key key, this.postId, this.Email}) : super(key: key);
  Vendor_InqueryState createState() => Vendor_InqueryState();
}



class Vendor_InqueryState extends State<Vendor_Inquery> {

  String _date = "Not set";
  TextEditingController dateController ;
  TextEditingController fnameController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController purposeController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  //  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
//  final timeFormat = DateFormat("h:mm a");

  signIn(String fname,date,mobileNo,location,purpose,email) async {
    String postId;

    Map data={
      'customer_name': fname,
      'v_email': widget.Email,
      'vendor_id': widget.postId,
      'customer_id': 'id',
      'date': date,
      'mobileNo': mobileNo,
      'location': location,
      'purpose': purpose,
      'email': email

    };
    //  var jsonData = null;
    var response = await http.post('https://api-wediina.herokuapp.com/vendor_inquiry/', body: data);
    final posts = json.decode(response.body);

    print(posts);
  }


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

    String _formattedate = new DateFormat.yMMMd().format(date);

    if(_seldate!=null){
      setState(() {
        date = _seldate;
        var formatter = new DateFormat('dd/MM/yyyy');
        String formatted = formatter.format(date);

        dateController = new TextEditingController(text:formatted);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }


  _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    var myString = (prefs.getString('my_string_key') ?? '');
    String id = myString;
    print(id);


  }



//  var finaldate;
//
//  void callDatePicker() async {
//    var order = await getDate();
//    setState(() {
//      finaldate = order;
//      fnameController = new TextEditingController(text:finaldate);
//    });
//  }
//
//  Future<DateTime> getDate() {
//
//    return showDatePicker(
//      context: context,
//      initialDate: DateTime.now(),
//      firstDate: DateTime(2018),
//      lastDate: DateTime(2030),
//      builder: (BuildContext context, Widget child) {
//        return Theme(
//          data: ThemeData.light(),
//          child: child,
//        );
//      },
//    );
//  }


  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMd().format(date);

    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        title: Text('inquiry'),
        backgroundColor: Colors.redAccent[200],
      ),



      body:
      ListView(
        children: <Widget>[
          Container(
            child: id == null ? Container(
              child: new Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Send Inquiry',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),



                  //main section
                  Container(
                    child: Column(
                      children: <Widget>[

                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: fnameController,
                            decoration: const InputDecoration(
                              labelText: 'Your Name',
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
                                return 'Your Name is required';
                              }
                            },
                          ),
                        ),



                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
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
                                return 'Email is required';
                              }
                            },
                          ),
                        ),



                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: mobileNoController,
                            decoration: const InputDecoration(
                              labelText: 'Mobile No',
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


                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: locationController,
                            decoration: const InputDecoration(
                              labelText: 'location',
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
                                return 'No of Person is required';
                              }
                            },
                          ),
                        ),


                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: purposeController,
                            decoration: const InputDecoration(
                              labelText: 'purpose',
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
                                return 'purpose is required';
                              }
                            },
                          ),
                        ),


                        Container(
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
                            enabled: true,
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

                        Container(
                          alignment: Alignment.center,
                          child: OutlineButton(
                            highlightedBorderColor: Colors.black,
                            onPressed: () {
                              signIn(emailController.text, dateController.text,
                                  purposeController.text,locationController.text,
                                  mobileNoController.text,fnameController.text
                              );
                            },
                            child: const Text('Register'),
                          ),
                        ),

                        // mainscreen
                      ],
                    ),
                  ),


                ],
              ),


            ) : Container(

                //child: Logincustmer()


            ),

          ),
          //name

        ],
      ),

    );
  }





}
