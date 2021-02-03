import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:validate/validate.dart';
import 'package:wediina_bussniss/businessprofile/businessprofile_page.dart';

import 'package:wediina_bussniss/mainscreen/homepage.dart';

class Logindemoerrorwithpop extends StatefulWidget {
  Logindemoerrorwithpop({Key key}) : super(key: key);
  String myString;
  LogincustmerState createState() => LogincustmerState();
}

class _LoginData {
  String email = '';

}

class LogincustmerState extends State<Logindemoerrorwithpop> {

  List<String> user;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  signIn(String email, password,) async {

    Map data={
      'email': email,
      'password':password
    };
    //  var jsonData = null;
    final prefs = await SharedPreferences.getInstance();
    var response = await http.post("https://api-wediina.herokuapp.com/customerLogin", body: data);
    if( response.statusCode == 200 ){
      final posts = json.decode(response.body);

      var  customer = prefs.getString('token') ?? posts['result']['_id'];
      prefs.setString('token', posts['result']['_id']);
      print(customer);

      setState((){
        var  customer = prefs.getString('token') ?? posts['result']['_id'];
        prefs.setString('token', posts['result']['_id']);
        print(customer);

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(BuildContext context) => Businessprofilepage() ),
                ( Route<dynamic> route ) => false);
      }

      );
    }
    else {
      if( response.statusCode == 401 ){

        setState((){

//          showDialog(
//              context: context,
//              builder: (BuildContext context) => passwordnotvalid(context));

//          Scaffold.of(context).showSnackBar(SnackBar(
//            content: Text('Password not valid'),
//            duration: Duration(seconds: 5),
//          ));

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Button moved to separate widget'),
            duration: Duration(seconds: 5),
          ));




        }

        );
      }
      else{
        if( response.statusCode == 404 ){

          setState((){

            showDialog(
                context: context,
                builder: (BuildContext context) => usernotfound(context));

//            Scaffold.of(context).showSnackBar(SnackBar(
//              content: Text('User not Found '),
//              duration: Duration(seconds: 5),
//            ));



          }

          );
        }



      }







    }








  }





  send(String sendemail,) async {

    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      Map data = {
        'email': sendemail,

      };
      //  var jsonData = null;
      final prefs = await SharedPreferences.getInstance();
      var response = await http.post(
          "https://api-wediina.herokuapp.com/forgot_customer_password",
          body: data);
      if (response.statusCode == 200) {
        final posts = json.decode(response.body);


        setState(() {
//        showDialog(
//            context: context,
//            builder: (BuildContext context) => _showDialog(context)
//        );


          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => Homescreen()),
                  (Route<dynamic> route) => false);
        }

        );
      }
      else {
        print(response.body);
      }
    }
  }


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController sendemailController = new TextEditingController();

  _LoginData _data = new _LoginData();

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
      body:

      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/background1.jpeg',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,
              ),
            ),


            Container(
              margin: new EdgeInsets.only(left: 10,right: 10,top: 60),
              width: size.width,
              height: 360,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            Container(
              child: _buildBody(context),
            ),




          ],
        ),
      ),




    );

  }

  Widget _buildBody(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      child:ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  width: size.width,
                  child: Stack(
                    children: <Widget>[

                      Container(
                        margin: new EdgeInsets.only(left: 10,right: 10,top: 60),
                        width: size.width,
                        height: 360,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [
                                      0.1,
                                      0.4,
                                      0.6,
                                      0.9
                                    ], colors: [
                                  Colors.white10,
                                  Colors.white10,
                                  Colors.white10,
                                  Colors.white10,
                                ]
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.all(Radius.circular(10)),
//              boxShadow: <BoxShadow>[
//                new BoxShadow(
//                  color: Colors.redAccent[100],
//                  blurRadius: 10.0,
//                  offset: new Offset(0.0, 3.0),
//                ),
//              ],
                              ),
                            ),

                            Container(
                              child: ListView(
                                children: <Widget>[
                                  Container(
                                    margin: new EdgeInsets.only(left: 30.0,right: 20,top: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          margin: new EdgeInsets.only(top:10),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text("Business Login",
                                                  style: TextStyle(fontSize: 20.0,
                                                    color: Colors.white,
                                                  ),
                                                ),

                                              ),
                                            ],
                                          ),
                                        ),



                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: new EdgeInsets.only(right: 60),
                                                alignment: Alignment.topLeft,
                                                child: Text("Your Name",
                                                  style: TextStyle(fontSize: 18.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: new EdgeInsets.only(left: 116,right: 6),

                                                alignment: Alignment.topRight,
                                                child: Icon(Icons.person, color: Colors.white,size: 18,),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          color: Colors.white,
                                          margin: new EdgeInsets.only(top:6),
                                          child: TextFormField(
                                            controller: emailController,
                                            decoration: const InputDecoration(
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
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
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: new EdgeInsets.only(right: 60,top: 10),
                                                alignment: Alignment.topLeft,
                                                child: Text("Password",
                                                  style: TextStyle(fontSize: 18.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: new EdgeInsets.only(left: 126,right: 6,top: 10),
                                                alignment: Alignment.topRight,
                                                child: Icon(Icons.lock, color: Colors.white,size: 18,),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          color: Colors.white,
                                          margin: new EdgeInsets.only(top:6),
                                          child: TextFormField(
                                            controller: passwordController,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              //          icon: Icon(Icons.lock, color: Colors.white,size: 18,),
                                            ),


                                            validator: (String value) {
                                              if (value.trim().isEmpty) {
                                                return 'Password is required';
                                              }
                                            },
                                          ),
                                        ),


                                        Container(
                                          height: 40,
                                          margin: new EdgeInsets.only(top:20),
                                          alignment: Alignment.topRight,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 40,
                                                child:  OutlineButton(
                                                  borderSide: BorderSide(color: Colors.grey),
//                      //color: Colors.white,
//                      child: Text(
//                        'Forget  password?',
//                        style: TextStyle(
//                          fontSize: 16.0,
//                          color: Colors.white,
//                          fontWeight: FontWeight.bold,
//
//                        ),
//                      ),
//                      onPressed: () {},
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10.0)
//
//                      ),
                                                  onPressed:(){

                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => _modalBottomSheetMenu(context),
                                                      ),
                                                    );

//                                                    showDialog(
//                                                        context: context,
//                                                        builder: (BuildContext context) => _showDialog(context));
                                                  },

                                                  child: const Text('Forget password'),



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
                      ),

                      Container(
                        height: 60,
                        margin: new EdgeInsets.only(top:390),

                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
//                Container(
//                  height: 50,
//                  width: 140,
//                  decoration: new BoxDecoration(
//                    color: Colors.grey,
//                    shape: BoxShape.rectangle,
//                    borderRadius: new BorderRadius.all(Radius.circular(30)),
//                    boxShadow: <BoxShadow>[
//                      new BoxShadow(
//                      //  color: Colors.redAccent[100],
//                        blurRadius: 10.0,
//                        offset: new Offset(0.0, 3.0),
//                      ),
//                    ],
//                  ),
//                ),
                            Container(
                              child: Align(
                                alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                                child: RaisedButton(

                                  onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
                                    signIn(emailController.text, passwordController.text);
                                  },
                                  color: Colors.red,
                                  child:  Text('Login',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,

                                    ),

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


  Widget _showDialog(BuildContext context) {


    Size size = MediaQuery
        .of(context)
        .size;
    return Dialog(
      child: Container(
        height: 160,
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[

              new TextFormField(
                  keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                  controller: sendemailController,
                  decoration: new InputDecoration(
                      hintText: 'you@example.com',
                      labelText: 'E-mail Address'
                  ),
                  validator: this._validateEmail,
                  onSaved: (String value) {
                    this._data.email = value;
                  }
              ),

              Container(
                color: Colors.redAccent[100],
                height: 30.0,
                width: size.width,
                margin: new EdgeInsets.only(top:10),
                child: RaisedButton(
                  child: Text('Send'),
                  onPressed: sendemailController.text == ""  ? null : () {
                    send(sendemailController.text);
                  }, //specify background color  of button from our list of colors
                ),
              ),
            ],
          ),



        ),


      ),



    );




  }


  Widget usernotfound(BuildContext context) {

    return Dialog(
      child: Container(
        height: 50,

        child: Text(
          'No User Found',
          // textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),


      ),



    );




  }



  Widget passwordnotvalid(BuildContext context) {

    return Dialog(
      child: Container(
        height: 50,

        child: Text(
          'Password not valid',
          // textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),


      ),



    );




  }












}


Widget _modalBottomSheetMenu(BuildContext context){
  bool checkingFlight = false;
  bool success = false;


  showModalBottomSheet<void>(
      context: context,
      builder: (builder){
        return new Container(
          height: 350.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your reference number',
                  ),
                )),

//          Container(
//              child:
//              RaisedButton(
//                color: Colors.grey[800],
//                onPressed: () {
//                },
//                child: Text(
//                  'Check Flight',
//                  style: TextStyle(color: Colors.white),
//                ),
//              )
//
//
//
//          ),





                ]

            ),
        );
      }
  );

}



