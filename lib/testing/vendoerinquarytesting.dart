import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
class Vendor_Inquery21 extends StatefulWidget {
  final String postId;

  final String Email;
   Vendor_Inquery21({Key key, this.postId, this.Email}) : super(key: key);
  Vendor_InqueryState createState() => Vendor_InqueryState();
}



class Vendor_InqueryState extends State<Vendor_Inquery21> {

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



      body:  new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    enabled: true,
                    controller: fnameController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                  ),

                  new TextFormField(
                    enabled: true,
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  Container(
                    child: IconButton(
                      onPressed: () {
                        selectdate(context);
                      },
                      icon: Icon(Icons.today),

                    ),
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Dob',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),



                  new TextFormField(
                    enabled: true,
                    controller: mobileNoController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),


                  new TextFormField(
                    enabled: true,
                    controller: mobileNoController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),




                  new TextFormField(
                    enabled: true,
                    controller: mobileNoController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),







                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: null,
                      )),
                ],
              ))),


    );
  }





}
