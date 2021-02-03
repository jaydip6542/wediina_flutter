import 'dart:convert';

//import 'package:flutter_appwithapi/vanue/vanue_persnoldetail.dart';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:wediina_bussniss/vanue/vanue_persnoldetail.dart';



class WhishList extends StatefulWidget {

  WhishList({ Key key, }) : super(key: key);
  @override
  WhishListState createState() => new WhishListState();

}

class WhishListState extends State<WhishList> {


  List countries = [];
  var customerdetail = {

  };


  getCountries() async {

    var response = await http.get('https://api-wediina.herokuapp.com/venue_by_id/5da9d42a44f3540017fc000c');
    final posts = json.decode(response.body );
    print(posts);
    return posts;

  }

  @override
  void initState() {
    getCountries().then((posts) {
      setState(() {
        customerdetail = posts;
        print(customerdetail);
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.redAccent[200],
      ),
      body:
      Column(
        children: <Widget>[
      Container(
          child: GestureDetector(
            onTap: () => _navigateToPost(context, customerdetail['_id']),
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
                                      customerdetail['image'])
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
                            child: Text(customerdetail['companyName'],
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
                                child: Text(customerdetail['address'],
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
          ),
      ),
    ],
    ),






//      ListView.builder(
//            itemCount: filteredCountries.length,
//            itemBuilder: (BuildContext context, int index) {
//              return
//                GestureDetector(
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
//            }),
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