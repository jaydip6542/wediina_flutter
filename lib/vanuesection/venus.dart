import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';

import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:wediina_bussniss/mainscreen/homepage.dart';

import 'package:http/http.dart' as http;
import 'package:wediina_bussniss/vanue/demovenudetail.dart';
import 'package:wediina_bussniss/vanue/vanue_detail.dart';
import 'package:wediina_bussniss/vanue/vanue_list.dart';
import 'package:wediina_bussniss/vendor/home_page.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';





class VenusPage extends StatefulWidget {

  VenusPage({Key key, }) : super(key: key);

  @override
  VenusPageState createState() => new VenusPageState();

}

class VenusPageState extends State<VenusPage> {






  GlobalKey _bottomNavigationKey = GlobalKey();


  List venus = [];
  List filteredCountries = [];
  bool isSearching = false;



  getVenus() async {
    var response = await http.get('https://api-wediina.herokuapp.com/venue_cat');
    final posts = json.decode(response.body );
    return posts;
  }

  @override
  void initState() {
    getVenus().then((posts) {
      setState(() {
        venus  = filteredCountries = posts;;
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = venus
          .where((venus) =>
          venus['venue_cat_name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.redAccent[200],
        title: !isSearching
            ? Text(' Vanues')
            : TextField(
          onChanged: (value) {
            _filterCountries(value);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search Venues Here",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching = false;
                filteredCountries = venus;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            },
          )
        ],
      ),

      body:Container(
        child: filteredCountries.length > 0
            ? GridView.builder(
          itemCount: filteredCountries.length,
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7.0,
            mainAxisSpacing: 7.0,
          ),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return new GestureDetector(
              onTap: () => _navigateToPost(context, filteredCountries[index]['_id']),
              child: Container(
                height: 100,
                child: Stack(
                  children: <Widget>[
                    //   margin: Edge//Insets.only(right: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(filteredCountries[index]['image'],),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            //begin: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(.5),
                                Colors.black.withOpacity(.5),
                              ]
                          )
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(filteredCountries[index]['venue_cat_name'],
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: TextStyle(color: Colors.white, fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
            :  Center(
          child: GlowingProgressIndicator(
            child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
          ),
        ),
      ),
          );
       }


//  Widget _buildPosts(BuildContext context, venus) {
//    return GridView.builder(
//
//      itemCount: venus.length,
//      padding: EdgeInsets.all(8),
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//        crossAxisSpacing: 7.0,
//        mainAxisSpacing: 7.0,
//
//      ),
//
//      scrollDirection: Axis.vertical,
//      itemBuilder: (context, index) {
//        return new GestureDetector(
//
//          onTap: () => _navigateToPost(context, venus[index]['_id']),
//
//          child: Container(
//            height: 100,
//
//            child: Stack(
//
//              children: <Widget>[
//
//                //   margin: Edge//Insets.only(right: 10),
//                Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      image: DecorationImage(
//                          image: NetworkImage(venus[index]['image'],),
//                          fit: BoxFit.fill
//                      )
//                  ),
//                ),
//                Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      gradient: LinearGradient(
//                        //begin: Alignment.bottomRight,
//                          colors: [
//                            Colors.black.withOpacity(.5),
//                            Colors.black.withOpacity(.5),
//
//                          ]
//                      )
//                  ),
//                ),
//                Container(
//                  child: Align(
//                    alignment: Alignment.center,
//                    child: Text(venus[index]['venue_cat_name'],
//                      textAlign: TextAlign.center,
//                      maxLines: 3,
//
//                      style: TextStyle(color: Colors.white, fontSize: 20,
//
//                      ),
//                    ),
//
//                  ),
//                ),
//              ],
//            ),
//
//          ),
//        );
//      },
//    );
//  }

  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenueList(postId: _id),
      ),
    );
  }
}