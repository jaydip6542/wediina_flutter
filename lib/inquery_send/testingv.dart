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
import 'package:validate/validate.dart';
class Vendor_Inquerytesting extends StatefulWidget {
  final String postId;

  final String Email;
  const Vendor_Inquerytesting({Key key, this.postId, this.Email}) : super(key: key);
  Vendor_InquerytestingState createState() => Vendor_InquerytestingState();
}
class _LoginData {
  String email = '';
  String purpose = '';
  String name = '';
  String mobile = '';
  String location = '';
  String Date = '';
}


class Vendor_InquerytestingState extends State<Vendor_Inquerytesting> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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


  _LoginData _data = new _LoginData();





  void submit(String fname,date,mobileNo,location,purpose,email) async {
    // First validate form.




    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

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

      var response = await http.post('https://api-wediina.herokuapp.com/vendor_inquiry/', body: data);
      final posts = json.decode(response.body);







    }
  }




  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }




  String _validateMobile(String value) {
    if (value.length < 10) {
      return 'The Mobile No must be at least 8 characters.';
    }

    return null;
  }


  String _validateName(String value) {
    if (value.length < 1) {
      return 'Your Name must be required.';
    }

    return null;
  }



  String _validatelocation(String value) {
    if (value.length < 1) {
      return 'Your location must be required.';
    }

    return null;
  }

  String _validatepurpose(String value) {
    if (value.length < 1) {
      return 'Your Purpose must be required.';
    }

    return null;
  }


  String _validateDate(String value) {
    if (value.length < 1) {
      return 'Date must be required.';
    }

    return null;
  }














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
        title: Text('Send Inquary'),
        backgroundColor: Colors.redAccent[200],
      ),



      body:


          Container(
              padding: new EdgeInsets.all(20.0),
               child: new Form(
                key: this._formKey,
                child: new ListView(
                  children: <Widget>[


                    new TextFormField(
                         // Use secure text for passwords.
                        controller: fnameController,
                        decoration: new InputDecoration(
                            hintText: 'Your Name',
                            labelText: 'Enter your Name'
                        ),
                        validator: this._validateName,
                        onSaved: (String value) {
                          this._data.name = value;
                        }
                    ),


                    new TextFormField(
                        keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                        controller: emailController,
                        decoration: new InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'E-mail Address'
                        ),
                        validator: this._validateEmail,
                        onSaved: (String value) {
                          this._data.email = value;
                        }
                    ),

                    new TextFormField(
                         // Use secure text for passwords.
                        controller: mobileNoController,
                        decoration: new InputDecoration(
                            hintText: 'Mobile No',
                            labelText: 'Enter your Mobile No'
                        ),
                        validator: this._validateMobile,
                        onSaved: (String value) {
                          this._data.mobile = value;
                        }
                    ),


                    new TextFormField(
                         // Use secure text for passwords.
                        controller: locationController,
                        decoration: new InputDecoration(
                            hintText: 'location',
                            labelText: 'Enter your location'
                        ),
                        validator: this._validatelocation,
                        onSaved: (String value) {
                          this._data.location = value;
                        }
                    ),


                    new TextFormField(
                         // Use secure text for passwords.
                        controller: purposeController,
                        decoration: new InputDecoration(
                            hintText: 'purpose',
                            labelText: 'Enter your purpose'
                        ),
                        validator: this._validatepurpose,
                        onSaved: (String value) {
                          this._data.purpose = value;
                        }
                    ),

                    Container(
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
                            child: new TextFormField(

                                enabled: false,// Use secure text for passwords.
                                controller: dateController,
                                decoration: new InputDecoration(
                                    hintText: 'Date',
                                    labelText: 'Enter Date'
                                ),
                                validator: this._validateDate,
                                onSaved: (String value) {
                                  this._data.Date = value;
                                }
                            ),
                          ),


                        ],
                      ),

                    ),
                 Container(
                   alignment: Alignment.center,
                   child: new OutlineButton(
                     highlightedBorderColor: Colors.redAccent,
                     child: new Text(
                     'Send',
                     style: new TextStyle(
                         color: Colors.black
                     ),
                   ),
                     onPressed: () {
                       submit(emailController.text, dateController.text,
                           purposeController.text,locationController.text,
                           mobileNoController.text,fnameController.text
                       );
                     },







                 ),







                 ),












                  ],
                ),


              ),

























          ),
          //name



    );
  }





}
