import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wediina_bussniss/mainscreen/homepage.dart';

class Businesslogin21 extends StatefulWidget {
  final String  postId;
  String myString;
  Businesslogin21({Key key, this.postId}) : super(key: key);
  Businesslogin21State createState() => Businesslogin21State();
}



class Businesslogin21State extends State<Businesslogin21> {
  List<String> user;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  signIn(String email, password,) async {

    Map data={
      'email': email,
      'password':password
    };
    //  var jsonData = null;
    final prefs = await SharedPreferences.getInstance();
    var response = await http.post("https://api-wediina.herokuapp.com/venueLogin", body: data);
    if( response.statusCode == 200 ){
      final posts = json.decode(response.body);

      var  myStringBus = prefs.getString('my_string_keyBus') ?? posts['_id'];
      prefs.setString('my_string_keyBus', posts['_id']);
      print(myStringBus);

      setState((){
        var  myStringBus = prefs.getString('my_string_keyBus') ?? posts['_id'];
        prefs.setString('my_string_keyBus', posts['_id']);
        print(myStringBus);

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(BuildContext context) => Homescreen() ),
                ( Route<dynamic> route ) => false);
      }

      );
    }
    else {
      print(response.body);
    }
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


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
      key: _scaffoldKey,

      body:  Center(
        child: Column(
          children: <Widget>[
            Container(

              child: Stack(
                children: <Widget>[

                  Container(
                    margin: new EdgeInsets.only(left: 30.0,right: 30,top: 60),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: new EdgeInsets.only(left: 30.0,right: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text("Email",
                                  style: TextStyle(fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                  child: Icon(Icons.person, color: Colors.black,size: 16,)),

                            ],
                          ),
                        ),



                        Container(
                          height: 50,
                          margin: new EdgeInsets.only(left: 30.0,right: 20),
                          child: TextFormField(
                            controller: emailController,
                            //controller: _pageController,
                            decoration: const InputDecoration(
                              border: const OutlineInputBorder(
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
                          margin: new EdgeInsets.only(left: 30.0,right: 20),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Contact No is required';
                              }
                            },
                          ),
                        ),


                        Container(
                          alignment: Alignment.center,
                          child: OutlineButton(
                            highlightedBorderColor: Colors.black,
                            onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
                              signIn(emailController.text, passwordController.text);
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],





        ),
      ),

    );
  }

}