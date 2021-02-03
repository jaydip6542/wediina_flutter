import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class customer_myvendor  extends StatefulWidget {
  final String postId;

  const customer_myvendor({Key key, this.postId}) : super(key: key);
  myvanuesState createState() => myvanuesState();
}



class myvanuesState extends State<customer_myvendor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  var countries = {

  };


  TextEditingController fnameController;
  TextEditingController lnameController;
  TextEditingController companyNameController;



  getCountries() async {
    TextEditingController emailController;
    var response = await http.get('https://api-wediina.herokuapp.com/venue_by_id/5dcc2ee3eaf2e70017ecb073');
    final posts = json.decode(response.body);
    return posts;

  }



  @override
  void initState() {
    getCountries().then((posts) {
      setState(() {
        countries = posts ;

        fnameController = new TextEditingController(text: posts['fname']);
        lnameController = new TextEditingController(text: posts['contact_no']);
        companyNameController = new TextEditingController(text: posts['email']);

//        //  print(countries['cop']);

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

      body: ListView(
        children: <Widget>[
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Your vanues',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            child: Column(
              children: <Widget>[

                //ordernumber
                Container(
                  child: Row(
                    children: <Widget>[

                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: new EdgeInsets.only(top: 10,right: 10,left: 10 ),
                              height: 50.0,
                              width: 80,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.redAccent[200]
                                ),
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                            ),
                            Container(
                              margin: new EdgeInsets.only(top: 10,right: 20,left: 10 ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: new EdgeInsets.only( right: 10,left: 30,top: 2),
                                    child: Text('No',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only( right: 10,left: 30,top: 2),
                                    child: Text('1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //vanue name
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: new EdgeInsets.only(top: 10 ,right: 20),
                              height: 50.0,
                              width: 240,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.redAccent[200]
                                ),
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              width: 240,
                              margin: new EdgeInsets.only(top: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: new EdgeInsets.only(top: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Venue Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: new EdgeInsets.only(top: 5),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("krishna party ploat",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0,
                                          color: Colors.black,

                                        ),
                                      ),
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


                //inquarydate
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: new EdgeInsets.only(top: 10,left: 10,right: 10),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width/2-20,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.redAccent[200]
                                ),
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                            ),

                            Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width/2-20,
                              margin: new EdgeInsets.only(top: 10,left: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: new EdgeInsets.only(top: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Inquiry Date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: new EdgeInsets.only(top: 5),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(countries['bookingdate'][0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),

                      //inquarydate
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: new EdgeInsets.only(top: 10,right: 20),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width/2-20,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.redAccent[200]
                                ),
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                            ),

                            Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width/2-20,
                              margin: new EdgeInsets.only(top: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: new EdgeInsets.only(top: 2),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Booking Date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: new EdgeInsets.only(top: 5),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(countries['bookingdate'][1],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0,
                                          color: Colors.black,

                                        ),
                                      ),
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

                //no of person
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: new EdgeInsets.only(top: 10,left: 10,right: 20),
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.redAccent[200]
                          ),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),

                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        margin: new EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: new EdgeInsets.only(top: 2),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('No. Of Person',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: new EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("100",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0,
                                    color: Colors.black,

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),


                //detail
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: new EdgeInsets.only(top: 10,right: 20,left: 10),
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.redAccent[200]
                          ),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),

                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        margin: new EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: new EdgeInsets.only(top: 2),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Detail',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: new EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(countries['fname'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0,
                                    color: Colors.black,

                                  ),
                                ),
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









        ],
      ),

    );
  }




}