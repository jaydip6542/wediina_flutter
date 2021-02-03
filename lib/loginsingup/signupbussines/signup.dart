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

class Signup extends StatefulWidget {
 // final String postId;
  //final String Email;
   Signup({Key key,}) : super(key: key);
  SignupState createState() => SignupState();
}



class SignupState extends State<Signup> {

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







  //String _date = "Not set";
  //TextEditingController dateController  ;
  TextEditingController fnameController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController gstController = new TextEditingController();
  //  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
//  final timeFormat = DateFormat("h:mm a");

  signIn(String fname,date,mobileNo,location,purpose,email) async {
    String postId;

    Map data={
      'customer_name': fname,

      'customer_id': 'id',
      'date': date,
      'mobileNo': mobileNo,
      'location': location,
      'purpose': purpose,
      'email': email

    };
    //  var jsonData = null;
    var response = await http.post('https://api-wediina.herokuapp.com/venue_inquiry/', body: data);
    final posts = json.decode(response.body);

    print(posts);
  }


  String id;



//  DateTime date = new DateTime.now();

  // TimeOfDay time;
//  var myFormat = DateFormat('d-MM-yyyy');
//  Future<Null> selectdate(BuildContext context) async {
//    final DateTime _seldate = await showDatePicker(
//        context: context,
//        initialDate: date,
//        firstDate: DateTime(2018,8),
//        lastDate: DateTime(2030),
//        builder: (context, child)
//        {
//          return SingleChildScrollView(child: child,);
//        }
//    );
//
//    String _formattedate = new DateFormat.yMMMd().format(date);
//
//    if(_seldate!=null){
//      setState(() {
//        date = _seldate ?? date;
//        dateController = new TextEditingController(text: '${myFormat.format(date)}');
//      });
//    }
//  }


 // TextEditingController _datecontroller = new TextEditingController();



//  Future<void> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: date,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    setState(() {
//      date = picked ?? date;
//    });
//  }



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
    //String _formattedate = new DateFormat.yMMMd().format(date);

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
                              labelText: 'First Name',
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
                                return 'First Name is required';
                              }
                            },
                          ),
                        ),



                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: lnameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
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
                                return 'Last Name is required';
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
                            controller: addressController,
                            decoration: const InputDecoration(
                              labelText: 'Address',
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
                                return 'Address is required';
                              }
                            },
                          ),
                        ),

                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child:  TextFormField(
                            enabled: true,
                            controller: gstController,
                            decoration: const InputDecoration(
                              labelText: 'GST No.',
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
                                return 'GST No. is required';
                              }
                            },
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



//
//                          InkWell(
//                            onTap: () => _selectDate(context),
//                            child: IgnorePointer(
//                              child: TextField(
//                                controller: _datecontroller,
//                                decoration: InputDecoration(
//
//                                  hintText: ('${myFormat.format(date)}'),
//                                ),
//
//                              ),
//                            ),
//                          ),


//                        Container(
//                          child: IconButton(
//                            onPressed: () {
//                              selectdate(context);
//                            },
//                            icon: Icon(Icons.today),
//
//                          ),
//                        ),

//                        Container(
//                          height: 50,
//                          margin: new EdgeInsets.only(left: 30.0,right: 20),
//                          child:
//                          TextFormField(
//                            enabled: true,
//                            controller: dateController,
//                            decoration: const InputDecoration(
//                              labelText: 'Date',
//                              labelStyle: TextStyle(
//                                color: Colors.black, fontSize: 14,
//                                fontWeight: FontWeight.w900,
//                              ),
//                              border: const OutlineInputBorder(
//                                borderSide: BorderSide(color: Colors.black),
//                              ),
//
//                              focusedBorder: const OutlineInputBorder(
//                                borderSide: BorderSide(color: Colors.black),
//                              ),
//                            ),
//                            validator: (String value) {
//                              if (value.trim().isEmpty) {
//                                return 'Mobile No is required';
//                              }
//                            },
//                          ),
//
//                        ),

                        Container(
                          alignment: Alignment.center,
                          child: OutlineButton(
                            highlightedBorderColor: Colors.black,
                            onPressed: () {
                              signIn(emailController.text, gstController.text,
                                  lnameController.text,addressController.text,
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
