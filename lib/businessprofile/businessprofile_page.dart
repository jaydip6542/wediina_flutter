

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wediina_bussniss/businessprofile/businesschange_password.dart';
import 'package:wediina_bussniss/businessprofile/myvanues.dart';
import 'package:wediina_bussniss/buttomnavigationbar/buttomnavigationbar.dart';


import 'businesspersnoldetail_page.dart';

class Businessprofilepage extends StatefulWidget {
  final String postId;
  String myString ='';
  Businessprofilepage({Key key, this.postId}) : super(key: key);
  BusinessprofilepageState createState() => BusinessprofilepageState();
}
class BusinessprofilepageState extends State<Businessprofilepage> {

  var customer = {

  };
  String id;
  var posts={};



  @override
  void initState() {
    _loadCounter();
//    getCountries().then((posts) {
//      setState(() {
//        customer = posts;
//      });
//    });
    super.initState();
    _loadCounter();
  }


  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myStringBus = (prefs.getString('my_string_keyBus')??'');
    String id = myStringBus;
    //print(id);
    getCountries(id).then((posts) {
      setState(() {
        customer = posts;
      });
    });

  }

  getCountries(id) async {

    var response = await http.get('https://api-wediina.herokuapp.com/Venue_by_id/5dca94c51a01d10017d14b19');
    final posts = json.decode(response.body);
    print(id);
    print(posts);

    return posts;

  }

  @override
  Widget build(BuildContext context) {
    //print(id);
    Size size = MediaQuery.of(context).size;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vanues Details'),
        backgroundColor: Colors.redAccent[200],
      ),
      body:Container(
        child: customer.length > 0
            ? Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100.0,),
              child: Column(
                children: <Widget>[
                  //   SizedBox(height: screenSize.height / 6.4),
                  Container(
                    child: Text(
                      customer['companyName'],
                      style:  TextStyle(fontFamily: 'Roboto',
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      customer['email'],
                      style: TextStyle(
                        fontFamily: 'Spectral',
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  // my detail
                  Container(
                    margin: EdgeInsets.only(top: 15.0,),
                    child: GestureDetector(
                      onTap:() => _navigateToPersnoldetail(context, customer['_id']),
                      child:Container(
                        height: 60.0,
                        child: new Stack(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 5.0,
                                    offset: new Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 16.0,right: 10.0,bottom: 15.0),
                                    child: Icon(Icons.person,color: Colors.redAccent,size: 30.0,),
                                  ),
                                  Container(

                                    margin: EdgeInsets.only(top: 15.0,left: 90.0,bottom: 15.0),
                                    child: Text("My Detali",

                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'Spectral',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 110.0,right: 5.0,bottom: 15.0),
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent,size: 30.0,),
                                  ),
                                ],
                              ),


                            ),

                          ],
                        ),
                      ),
                    ),
                  ),



                  //  My Venue
                  Container(height: 10.0,),
                  Container(
                    child: GestureDetector(
                      onTap:() => _navigateToMyvanues(context, customer['_id']),
                      child:Container(
                        height: 60.0,
                        child: new Stack(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 5.0,
                                    offset: new Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 16.0,right: 10.0,bottom: 15.0),
                                    child: Icon(Icons.person,color: Colors.redAccent,size: 30.0,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 80.0,bottom: 15.0),
                                    child: Text("My Venue",
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'Spectral',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 110.0,right: 5.0,bottom: 15.0),
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent,size: 30.0,),
                                  ),
                                ],
                              ),


                            ),
                          ],
                        ),
                      ),
                    ),
                  ),





                  // Change Password
                  Container(height: 10.0,),
                  Container(
                    child: GestureDetector(
                      onTap:() => _navigateToPassword(context, customer['_id']),
                      child:Container(
                        height: 60.0,
                        child: new Stack(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 5.0,
                                    offset: new Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 16.0,bottom: 15.0),
                                    child: Icon(Icons.lock,color: Colors.redAccent,size: 30.0,),

                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 70.0,bottom: 15.0),
                                    child: Text("Change Password",
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'Spectral',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 70.0,right: 5.0,bottom: 15.0),
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent,size: 30.0,),
                                  ),
                                ],
                              ),


                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  // My Vendors
                  Container(height: 10.0,),
                  Container(
                    child: GestureDetector(
                      onTap:() => _navigateToMyvandors(context, customer['_id']),
                      child:Container(
                        height: 60.0,
                        child: new Stack(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 5.0,
                                    offset: new Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 16.0,right: 10.0,bottom: 15.0),
                                    child: Icon(Icons.person,color: Colors.redAccent,size: 30.0,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 80.0,bottom: 15.0),
                                    child: Text("My Vendors",
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'Spectral',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 90.0,right: 5.0,bottom: 15.0),
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent,size: 30.0,),
                                  ),
                                ],
                              ),


                            ),
                          ],
                        ),
                      ),
                    ),
                  ),



                  //Logout
                  Container(height: 10.0,),
                  Container(
                    child: GestureDetector(
                      onTap: ()  async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('my_string_keyBus');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => BottomNavBar()));
                      },

                      child:Container(
                        height: 60.0,
                        child: new Stack(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(5.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 5.0,
                                    offset: new Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 16.0,right: 10.0,bottom: 15.0),
                                    child: Icon(Icons.person,color: Colors.redAccent,size: 30.0,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 90.0,bottom: 15.0),
                                    child: Text("Logout",
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'Spectral',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0,left: 110.0,right: 5.0,bottom: 15.0),
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent,size: 30.0,),
                                  ),
                                ],
                              ),


                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ],
        )
            :  Center(
          child: GlowingProgressIndicator(
            child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
          ),
        ),

      ),


    );
  }


  void _navigateToPersnoldetail(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Busonesspersnoldetail(postId: _id),
      ),
    );
  }
  void _navigateToPassword(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Customerchangepassword(postId: _id),
      ),
    );
  }
  void _navigateToMyvanues(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => myvanues(postId: _id),
      ),
    );
  }

  void _navigateToMyvandors(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => myvanues(postId: _id),
      ),
    );
  }


}