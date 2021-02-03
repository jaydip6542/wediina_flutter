import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wediina_bussniss/businessprofile/businessprofile_page.dart';

class Customerchangepassword extends StatefulWidget {
  final String postId;

  const Customerchangepassword({Key key, this.postId}) : super(key: key);
  CustomerchangepasswordState createState() => CustomerchangepasswordState();
}



class CustomerchangepasswordState extends State<Customerchangepassword> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  TextEditingController fnameController =  new TextEditingController();

  TextEditingController lnameController=  new TextEditingController();



  signIn(String fname,lname,) async {

    Map data={
      'password': fname,
    };
    //  var jsonData = null;
    var response = await http.put('https://api-wediina.herokuapp.com/validate_venue_password/'+(widget.postId), body: data);
    if( response.statusCode == 200 ){
      final posts = json.decode(response.body);
      //return posts;
      print(posts);

      setState(() async {

        print(lname);
        Map data={
          'password': lname,
        };
        var response = await http.put('https://api-wediina.herokuapp.com/venue_pwd_update/'+(widget.postId), body: data);
        final posts1 = json.decode(response.body);
        //return posts;
        print(posts1);
        setState((){

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Businessprofilepage(),
            ),
          );

//          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(BuildContext context) => Businessprofilepage() ),
//                  ( Route<dynamic> route ) => false);
        }
        );
      });

    }
    else {
      throw Exception('current password is wrong');
    }
  }


//  @override
//  void initState() {
//    getCountries().then((posts) {
//      setState(() {
//        countries = posts ;
////
////        fnameController = new TextEditingController(text: posts['name']);
////        lnameController = new TextEditingController(text: posts['contact_no']);
////        companyNameController = new TextEditingController(text: posts['email']);
////
////        //  print(countries['cop']);
//
//      });
//    });
//    super.initState();
//
//
//  }


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
      Column(
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.center,
              child: Text("Change  Password",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(color: Colors.white, fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            child: Form(
              key: _scaffoldKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20),
                    child:  TextFormField(
                      enabled: true,
                      controller: fnameController,
                      decoration: const InputDecoration(
                        labelText: 'current password',
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
                          return 'Full Name is required';
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 50,
                    margin: new EdgeInsets.only(left: 30.0,right: 20),
                    child:
                    TextFormField(
                      enabled: true,
                      controller: lnameController,
                      decoration: const InputDecoration(
                        labelText: 'new password',
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
                          return 'confime password';
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
                        signIn( fnameController.text, lnameController.text,);
                      },
                      child: const Text('Register'),
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