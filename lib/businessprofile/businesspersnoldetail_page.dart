import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_appwithapi/businessprofile/businessprofile_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wediina_bussniss/businessprofile/businessprofile_page.dart';

class Busonesspersnoldetail extends StatefulWidget {
  final String postId;

  const Busonesspersnoldetail({Key key, this.postId}) : super(key: key);
  BusonesspersnoldetailState createState() => BusonesspersnoldetailState();
}



class BusonesspersnoldetailState extends State<Busonesspersnoldetail> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var company = {

  };

  var posts = {

  };



  getCountries() async {
    TextEditingController emailController;
    var response = await http.get('https://api-wediina.herokuapp.com/venue_by_id/'+(widget.postId));
    final posts = json.decode(response.body);

    return posts;

  }
  TextEditingController fnameController;
  TextEditingController lnameController;
  TextEditingController companyNameController;
  TextEditingController areaController;
  TextEditingController contactnoController;
  TextEditingController emailController;
  TextEditingController cityController;
  TextEditingController parkingController;
  TextEditingController timeperController;
  TextEditingController areavenueController;
  TextEditingController copController;
  TextEditingController  gstnoController;
  TextEditingController  addressController;
  TextEditingController  catringValueController;
  TextEditingController  themepermissionController;
  TextEditingController  video_storyController;
  TextEditingController  bookingdateController;
  TextEditingController  venue_cat_idController;


  signIn(String fname,lname,contactno,email,city,gstno,address) async {
    String postId;
    print(company['fname']);
    Map data={
      'fname': fname,
      'lname': lname,
//      'companyName': posts['companyName'],
//      'area': posts['area'],
      'contactno': contactno,
      'email': email,
      'city': city,
      'parking': '200',
      'timeper': '12:00',
      'areavenue': 'rajkot ',
      'cop': '600',
  'alternetContactno': '962358654',
      'venue_cat_id': '5d8e843fe7f82b0017e5a4bf',
      'gstno': gstno,
     // 'password': posts['password'],
      'address': address,
//      'state': posts['state'],
    //   'catringValue': posts['catringValue'],
//      'themepermission': posts['themepermission'],
//      'location': posts['location'],
//      'desp': posts['desp'],
//      'video_story': posts['video_story'],
//      'bookingdate': posts['bookingdate'],
//      'alternetContactno': posts['alternetContactno'],
//      'username': posts['username'],
    };
    //  var jsonData = null;
//    var response = await http.put('https://api-wediina.herokuapp.com/venue_update/'+(widget.postId), body: data);
//    final posts1 = json.decode(response.body);
    var response = await http.put('https://api-wediina.herokuapp.com/venue_update/'+(widget.postId), body: data);
    print(response);
    setState((){

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(BuildContext context) => Businessprofilepage() ),
              ( Route<dynamic> route ) => false);
    }
    );


  }

  @override
  void initState() {
    getCountries().then((posts) {
      setState(() {
        company = posts ;

        fnameController = new TextEditingController(text: posts['fname']);
        lnameController = new TextEditingController(text: posts['lname']);
//        companyNameController = new TextEditingController(text: posts['companyName']);
//        areaController = new TextEditingController(text: posts['area']);
        contactnoController = new TextEditingController(text: posts['contactno']);
        emailController = new TextEditingController(text: posts['email']);
        cityController = new TextEditingController(text: posts['city']);
//        parkingController = new TextEditingController(text: posts['parking']);
//        timeperController = new TextEditingController(text: posts['timeper']);
//        areavenueController = new TextEditingController(text: posts['areavenue']);
//        copController = new TextEditingController(text: posts['cop']);
        gstnoController = new TextEditingController(text: posts['gstno']);
        addressController = new TextEditingController(text: posts['address']);
//        catringValueController = new TextEditingController(text: posts['catringValue']);
//        themepermissionController = new TextEditingController(text: posts['themepermission']);
//         video_storyController = new TextEditingController(text: posts['video_story']);
//        bookingdateController = new TextEditingController(text: posts['bookingdate']);
//        venue_cat_idController = new TextEditingController(text: posts['venue_cat_id']);


        //  print(countries['cop']);

      });
    });
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;


    return Scaffold(
      appBar: AppBar(
        title: Text('Wediina'),
        backgroundColor: Colors.redAccent[200],
      ),

      // key: _scaffoldKey,

      body:

      ListView(
        children: <Widget>[


          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: new EdgeInsets.only(top:20),
                  child: Text("Welcome to dashbord",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
//                Container(
//            child: Text(posts['companyName'],
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(fontSize: 15.0,
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold
//              ),
//            ),
//              ),
              ],
            ),


          ),
          Container(
             child: Form(
              key: _scaffoldKey,
              child: Column(
                children: <Widget>[

//                  Container(
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: Text("Your Detail",
//                        textAlign: TextAlign.center,
//                        maxLines: 3,
//                        style: TextStyle(color: Colors.white, fontSize: 20,
//                        ),
//                      ),
//                    ),
//                  ),



                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:  TextFormField(
                      controller: fnameController,
                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'First Name',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Full Name is required';
                        }
                      },
                    ),

                  ),

                  //const SizedBox(height: 10.0),

                  Container(

                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:
                    TextFormField(
                      controller: lnameController,
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'Last Name',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
//                        border: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
//
//                        focusedBorder: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Last Name is required';
                        }
                      },
                    ),
                  ),


                 // const SizedBox(height: 10.0),

                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:
                    TextFormField(

                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
//                        border: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
//
//                        focusedBorder: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Email is required';
                        }
                      },
                    ),
                  ),



                  //const SizedBox(height: 10.0),

                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:  TextFormField(

                      controller: contactnoController,
//                      decoration: InputDecoration(
//                          labelText: 'Enter your username'
//                      ),


                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'Mobile No',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),

//                        border: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
//
//                        focusedBorder: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Mobile No is required';
                        }
                      },
                    ),
                   ),

                   //const SizedBox(height: 10.0),

                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:  TextFormField(

                      controller: gstnoController,
//                      decoration: InputDecoration(
//                          labelText: 'Enter your username'
//                      ),


                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'GST No',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),


                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'GST No is required';
                        }
                      },
                    ),

                   ),

                  //const SizedBox(height: 10.0),

                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:  TextFormField(

                      controller: cityController,
//                      decoration: InputDecoration(
//                          labelText: 'Enter your username'
//                      ),


                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'City',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),

//                        border: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
//
//                        focusedBorder: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'City is required';
                        }
                      },
                    ),
                  ),




                  Container(
                    //height: 80,
                    margin: new EdgeInsets.only(left: 30.0,right: 20,top:20),
                    child:  TextFormField(

                      controller: addressController,
//                      decoration: InputDecoration(
//                          labelText: 'Enter your username'
//                      ),


                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.only(top:5),
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),

//                        border: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
//
//                        focusedBorder: const OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                        ),
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Address is required';
                        }
                      },
                    ),
                  ),










                  Container(
                    alignment: Alignment.center,
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      onPressed:  () {
                        //  _focusNode.unfocus();
                        signIn( fnameController.text, lnameController.text,
                          emailController.text,contactnoController.text,
                            gstnoController.text,cityController.text,
                            addressController.text

                        );
                      },
                      child: const Text('update'),
                    ),
                  ),









                ],
              ),
            ),

          ),
        ],
      ),



    );
  }





}