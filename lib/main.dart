
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:wediina_bussniss/loginsingup/signupbussines/signup.dart';
import 'package:wediina_bussniss/splashscreen/testingscrenn/splacescreentestingdemo.dart';
import 'businessprofile/businesspersnoldetail_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PostApiService.create(),
      dispose: (_, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title : 'Material App',

        home:
        //Democustomer(),
        //youtubedmo213(),
        //filterdatedemodemo(),
        //Logincustmer(),Splasescreen(),
        //VendorListdate(),
        //VendorList2(),
        //Vendors(),
        //BottomNavBar(),
        //Busonesspersnoldetail(),
        //MyApp988(),
        //customerlogin21(),
        //MyApp65(),
        //Profilecheck(),
        //Logincustmer(),
        //BottomNavBar(),
        // MyApp988(),
        //Democustomer(),

        //Logindemoerror(),


        //processbardemo(),
        // whiselistpage21(),
        //Logindemoerrorwithpop(),

       // Signup(),
        MyApp65953221(),









        //MyDemoProfile(),
        //MyDemoApp(),
        //LogInDemo(),
        //DemoLogIn(),
        // LogIn(),
        //MyAppDemo(),
        //HomePage1(),
        //BottomNavigationBarController(),

        // Homescreen(),
        // HomePage(),

        // Homescreen() ,
      ),
    );
  }
}
