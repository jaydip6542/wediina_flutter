//import 'dart:convert';
//import 'package:flutter_appwithapi/vanue/vanue_persnoldetail.dart';
//import 'package:http/http.dart' as http;
//import 'package:chopper/chopper.dart';
//import 'package:flutter/material.dart';
//import 'package:progress_indicators/progress_indicators.dart';
//import 'package:provider/provider.dart';
//
//
//
//class VenueList extends StatefulWidget {
//  String postId;
//  VenueList({ Key key,@required this.postId }) : super(key: key);
//  @override
//  VenueListPageState createState() => new VenueListPageState();
//
//}
//
//class VenueListPageState extends State<VenueList> {
//  String postId;
//
//  List countries = [];
//  List filteredCountries = [];
//  bool isSearching = false;
//
//
//
//  getCountries() async {
//
//    var response = await http.get('https://api-wediina.herokuapp.com/venue_by_cat_id/'+(widget.postId));
//    final posts = json.decode(response.body );
//    return posts;
//
//  }
//
//  @override
//  void initState() {
//    getCountries().then((posts) {
//      setState(() {
//        countries = filteredCountries = posts;
//      });
//    });
//    super.initState();
//  }
//
//  void _filterCountries(value) {
//    setState(() {
//      filteredCountries = countries
//          .where((country) =>
//          country['companyName'].toLowerCase().contains(value.toLowerCase()))
//          .toList();
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.redAccent[200],
//        title: !isSearching
//            ? Text('All Vanues')
//            : TextField(
//          onChanged: (value) {
//            _filterCountries(value);
//          },
//          style: TextStyle(color: Colors.white),
//          decoration: InputDecoration(
//              icon: Icon(
//                Icons.search,
//                color: Colors.white,
//              ),
//              hintText: "Search Venues Here",
//              hintStyle: TextStyle(color: Colors.white)),
//        ),
//        actions: <Widget>[
//          isSearching
//              ? IconButton(
//            icon: Icon(Icons.cancel),
//            onPressed: () {
//              setState(() {
//                this.isSearching = false;
//                filteredCountries = countries;
//              });
//            },
//          )
//              : IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {
//              setState(() {
//                this.isSearching = true;
//              });
//            },
//          )
//        ],
//      ),
//      body: Container(
//        //padding: EdgeInsets.all(10),
//        child: filteredCountries.length > 0
//            ? ListView.builder(
//            itemCount: filteredCountries.length,
//            itemBuilder: (BuildContext context, int index) {
//              return GestureDetector(
//                onTap: () => _navigateToPost(context, filteredCountries[index]['_id']),
//                child:Container(
//
//                    height: 118.0,
//                    margin: const EdgeInsets.symmetric(
//                      vertical: 5.0,
//                      horizontal: 15.0,
//                    ),
//
//                    child: new Stack(
//
//                      children: <Widget>[
//                        Container(
//                          height: 118.0,
//                          margin: new EdgeInsets.only(left: 35.0),
//                          decoration: new BoxDecoration(
//
//                            color: Colors.white,
//                            shape: BoxShape.rectangle,
//                            borderRadius: new BorderRadius.circular(5.0),
//                            boxShadow: <BoxShadow>[
//                              new BoxShadow(
//                                color: Colors.grey[500],
//                                blurRadius: 5.0,
//                                offset: new Offset(0.0, 3.0),
//                              ),
//                            ],
//                          ),
//
//                        ),
//                        Container(
//                          margin: new EdgeInsets.symmetric(
//                              vertical: 15.0
//                          ),
//                          alignment: FractionalOffset.centerLeft,
//                          child: Container(
//                              width: 93.0,
//                              height: 95.0,
//                              decoration: new BoxDecoration(
//                                  color: Colors.grey[200],
//
//                                  shape: BoxShape.circle,
//                                  // borderRadius:  BorderRadius.circular(3.0),
//                                  image: new DecorationImage(
//                                      fit: BoxFit.cover,
//
//                                      image: new NetworkImage(
//                                          filteredCountries[index]['image'])
//                                  )
//                              )),
//                        ),
//                        Container(
//                          //margin: new EdgeInsets.fromLTRB(120.0, 16.0, 20.0, 16.0),
//                          margin: new EdgeInsets.only(left: 120.0,right: 5.0),
//                          constraints: new BoxConstraints.expand(),
//                          child: new Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Container(
//                                margin:new EdgeInsets.all(2),
//                                child: Text(filteredCountries[index]['companyName'],
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  style: TextStyle(fontSize: 15.0,
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold
//                                  ),
//                                ),
//                              ),
//
//                              new Container(height: 6.0),
//                              new Row(
//
//                                mainAxisSize: MainAxisSize.min,
//                                children: [
//
//                                  Icon(Icons.location_on,color: Colors.grey[600],size: 15.0,),
//
//                                  SizedBox(
//                                    width: 150,
//                                    child: Text(filteredCountries[index]['address'],
//                                      maxLines: 1,
//                                      overflow: TextOverflow.ellipsis,
//                                      style: TextStyle(fontSize: 13.0),
//                                    ),
//                                  ),
//                                  // Text(posts[index]['city']),
//                                ],
//                              ),
//                              new Container(height: 6.0),
//                              new Stack(
//
//                                children: <Widget>[
//                                  Container(
//                                    margin: EdgeInsets.only(left: 2.0),
//                                    height: 20.0,
//                                    width: 50.0,
//                                    decoration: new BoxDecoration(
//                                      color: Colors.green[700],
//                                      shape: BoxShape.rectangle,
//                                    ),
//                                  ),
//                                  Container(
//                                    margin: EdgeInsets.only(left: 9.0,top: 2.0,bottom: 2.0),
//                                    child: new Row(
//
//                                      children: [
//
//                                        Icon(Icons.star,color: Colors.white,size: 15.0,),
//                                        Text("3.0",
//                                            style: TextStyle(color: Colors.white)
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ],
//                              ),
//
//                              new Container(height: 2.0),
//                              new Row(
//                                children:[
//                                  Text("Review",
//                                      style: TextStyle(color: Colors.black45)
//                                  ),
//
//                                  Container(
//                                    margin: EdgeInsets.only(left: 130.0,top: 5.0),
//                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent[100],size: 27.0,),
//
//                                  ),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ),
//
//                      ],
//
//                    )
//
//                ),
//              );
//            })
//            : Center(
//          child: GlowingProgressIndicator(
//            child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
//          ),
//        ),
//      ),
//
//    );
//  }
//
//  void _navigateToPost(BuildContext context, String _id) {
//    Navigator.of(context).push(
//      MaterialPageRoute(
//        builder: (context) => VanuesParsnolPage(postId: _id),
//      ),
//    );
//  }
//
//
//
//
//
//
//
//}




import 'dart:convert';
import 'package:wediina_bussniss/vanue/vanue_persnoldetail.dart';
import 'package:wediina_bussniss/vendor/detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';



class VenueList extends StatefulWidget {
  String postId;
  VenueList({ Key key,@required this.postId }) : super(key: key);
  @override
  VenueListState createState() => new VenueListState();

}

class VenueListState extends State<VenueList> {
  String postId;

  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;



  getCountries() async {

    var response = await http.get('https://api-wediina.herokuapp.com/venue_by_cat_id/'+(widget.postId));
    final posts = json.decode(response.body );

    return posts;
    print(widget.postId);

  }

  @override
  void initState() {
    getCountries().then((posts) {
      setState(() {
        countries = filteredCountries = posts;
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
          country['companyName'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[200],
        title: !isSearching
            ? Text('All Vendors')
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
              hintText: "Search Vendors Here",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching = false;
                filteredCountries = countries;
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
      body: Container(
        //padding: EdgeInsets.all(10),
        child: filteredCountries.length > 0
            ? ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _navigateToPost(context, filteredCountries[index]['_id']),
                child:Container(

                    height: 118.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15.0,
                    ),

                    child: new Stack(

                      children: <Widget>[
                        Container(
                          height: 118.0,
                          margin: new EdgeInsets.only(left: 35.0),
                          decoration: new BoxDecoration(

                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(5.0),
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.grey[500],
                                blurRadius: 5.0,
                                offset: new Offset(0.0, 3.0),
                              ),
                            ],
                          ),

                        ),
                        Container(
                          margin: new EdgeInsets.symmetric(
                              vertical: 15.0
                          ),
                          alignment: FractionalOffset.centerLeft,
                          child: Container(
                              width: 93.0,
                              height: 95.0,
                              decoration: new BoxDecoration(
                                  color: Colors.grey[200],

                                  shape: BoxShape.circle,
                                  // borderRadius:  BorderRadius.circular(3.0),
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,

                                      image: new NetworkImage(
                                          filteredCountries[index]['image'])
                                  )
                              )),
                        ),
                        Container(
                          //margin: new EdgeInsets.fromLTRB(120.0, 16.0, 20.0, 16.0),
                          margin: new EdgeInsets.only(left: 120.0,right: 5.0),
                          constraints: new BoxConstraints.expand(),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin:new EdgeInsets.all(2),
                                child: Text(filteredCountries[index]['companyName'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              new Container(height: 6.0),
                              new Row(

                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Icon(Icons.location_on,color: Colors.grey[600],size: 15.0,),

                                  SizedBox(
                                    width: 150,
                                    child: Text(filteredCountries[index]['address'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 13.0),
                                    ),
                                  ),
                                  // Text(posts[index]['city']),
                                ],
                              ),
                              new Container(height: 6.0),
                              new Stack(

                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 2.0),
                                    height: 20.0,
                                    width: 50.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.green[700],
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 9.0,top: 2.0,bottom: 2.0),
                                    child: new Row(

                                      children: [

                                        Icon(Icons.star,color: Colors.white,size: 15.0,),
                                        Text("3.0",
                                            style: TextStyle(color: Colors.white)
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              new Container(height: 2.0),
                              new Row(
                                children:[
                                  Text("Review",
                                      style: TextStyle(color: Colors.black45)
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 130.0,top: 5.0),
                                    child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent[100],size: 27.0,),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],

                    )

                ),
              );
            })
            :  Center(
          child: GlowingProgressIndicator(
            child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
          ),
        ),
      ),

    );
  }

  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VanuesParsnolPage(postId: _id),
      ),
    );
  }







}
