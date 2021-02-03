import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';

import 'package:wediina_bussniss/vendor/detail_page.dart';

class SinglePostPage extends StatelessWidget {
  final String postId;

  const SinglePostPage({
    Key key,
    this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor'),
        backgroundColor: Colors.redAccent[200],
      ),
      body:
      Stack(
        children: <Widget>[
          Container(
            child: new Image.asset(
              'assets/back_ground.jpg',
              repeat: ImageRepeat.repeat,
             width: size.width,
              height: size.height,
//              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: _buildBody(context),
          ),
        ],
      ),

    );
  }
  FutureBuilder<Response> _buildBody(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<PostApiService>(context).getVendorcat(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          final  List posts = json.decode(snapshot.data.bodyString);
          return _buildPosts(context, posts);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: GlowingProgressIndicator(
              child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
            ),
          );
        }
      },
    );
  }
  Widget _buildPosts(BuildContext context, List posts) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              verticalOffset: 80.0,
              child:SlideAnimation(
                child: GestureDetector(

                  onTap: () => _navigateToPost(context, posts[index]['_id']),
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
                                            posts[index]['image'])
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
                                  child: Text(posts[index]['companyName'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
//        new Container(height: 1.0),
//
//        new Text(posts[index]['address'],
//          overflow: TextOverflow.ellipsis,
//        ),



                                new Container(height: 6.0),
                                new Row(

                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Icon(Icons.location_on,color: Colors.grey[600],size: 15.0,),

                                    SizedBox(
                                      width: 150,
                                      child: Text(posts[index]['address'],
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
                                        color: Color(0xff5BA829),
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

//
//          new Container(height: 2.0),
//          new Padding(
//            padding:EdgeInsets.only(top:3.0),
////            child:Container(
////              height:1.5,
////              width:170.0,
////              color:Colors.black,
////
////
////            ),
////          child: Container(
////              height:0.7,
////             width:170.0,
////              decoration: new BoxDecoration(
////                  color: Colors.grey[300],
////
////                  //shape: BoxShape.rectangle,
////                  // borderRadius:  BorderRadius.circular(3.0),
//////                boxShadow: <BoxShadow>[
//////                  new BoxShadow(
//////                    color: Colors.grey[300],
//////
//////                    offset: new Offset(0.0, 2.0),
//////                  ),
//////                ],
////              )),
////
////          ),
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
            ),
          );
        },
      ),
    );
  }





  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(postId: _id),
      ),
    );
  }


//
//
//      ListView.builder(
//
//      //padding: EdgeInsets.all(8.0z),
//      itemCount: posts.length,
//
//      itemBuilder: (context, index) {
//        return new GestureDetector(
//
//          onTap: () => _navigateToPost(context, posts[index]['_id']),
//          child:Container(
//
//                     height: 118.0,
//                margin: const EdgeInsets.symmetric(
//              vertical: 5.0,
//                    horizontal: 15.0,
//        ),
//
//              child: new Stack(
//
//                children: <Widget>[
//              Container(
//                  height: 118.0,
//                      margin: new EdgeInsets.only(left: 35.0),
//                decoration: new BoxDecoration(
//
//             color: Colors.white,
//              shape: BoxShape.rectangle,
//              borderRadius: new BorderRadius.circular(5.0),
//              boxShadow: <BoxShadow>[
//                new BoxShadow(
//                 color: Colors.grey[500],
//                  blurRadius: 5.0,
//                  offset: new Offset(0.0, 3.0),
//               ),
//              ],
//            ),
//
//          ),
//            Container(
//                     margin: new EdgeInsets.symmetric(
//                 vertical: 15.0
//                    ),
//                alignment: FractionalOffset.centerLeft,
//               child: Container(
//                   width: 93.0,
//                   height: 95.0,
//                   decoration: new BoxDecoration(
//                       color: Colors.grey[200],
//
//                        shape: BoxShape.circle,
//                      // borderRadius:  BorderRadius.circular(3.0),
//                       image: new DecorationImage(
//                           fit: BoxFit.cover,
//
//                           image: new NetworkImage(
//                               posts[index]['image'])
//                       )
//                   )),
//          ),
//              Container(
//                //margin: new EdgeInsets.fromLTRB(120.0, 16.0, 20.0, 16.0),
//                margin: new EdgeInsets.only(left: 120.0,right: 5.0),
//        constraints: new BoxConstraints.expand(),
//        child: new Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//            margin:new EdgeInsets.all(2),
//         child: Text(posts[index]['companyName'],
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//          style: TextStyle(fontSize: 15.0,
//              color: Colors.black,
//              fontWeight: FontWeight.bold
//          ),
//        ),
//              ),
////        new Container(height: 1.0),
////
////        new Text(posts[index]['address'],
////          overflow: TextOverflow.ellipsis,
////        ),
//
//
//
//          new Container(height: 6.0),
//          new Row(
//
//            mainAxisSize: MainAxisSize.min,
//            children: [
//
//              Icon(Icons.location_on,color: Colors.grey[600],size: 15.0,),
//
//              SizedBox(
//                width: 150,
//              child: Text(posts[index]['address'],
//                maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
//                style: TextStyle(fontSize: 13.0),
//              ),
//              ),
//             // Text(posts[index]['city']),
//            ],
//          ),
// new Container(height: 6.0),
//          new Stack(
//           children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(left: 2.0),
//                height: 20.0,
//                width: 50.0,
//                decoration: new BoxDecoration(
//                  color: Color(0xff5BA829),
//                  shape: BoxShape.rectangle,
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.only(left: 9.0,top: 2.0,bottom: 2.0),
//                child: new Row(
//
//                  children: [
//
//                    Icon(Icons.star,color: Colors.white,size: 15.0,),
//                    Text("3.0",
//                        style: TextStyle(color: Colors.white)
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//
////
////          new Container(height: 2.0),
////          new Padding(
////            padding:EdgeInsets.only(top:3.0),
//////            child:Container(
//////              height:1.5,
//////              width:170.0,
//////              color:Colors.black,
//////
//////
//////            ),
//////          child: Container(
//////              height:0.7,
//////             width:170.0,
//////              decoration: new BoxDecoration(
//////                  color: Colors.grey[300],
//////
//////                  //shape: BoxShape.rectangle,
//////                  // borderRadius:  BorderRadius.circular(3.0),
////////                boxShadow: <BoxShadow>[
////////                  new BoxShadow(
////////                    color: Colors.grey[300],
////////
////////                    offset: new Offset(0.0, 2.0),
////////                  ),
////////                ],
//////              )),
//////
//////          ),
//       new Container(height: 2.0),
//       new Row(
//          children:[
//          Text("Review",
//              style: TextStyle(color: Colors.black45)
//          ),
//
//          Container(
//            margin: EdgeInsets.only(left: 130.0,top: 5.0),
//            child: Icon(Icons.keyboard_arrow_right,color: Colors.redAccent[100],size: 27.0,),
//
//          ),
//          ],
//       ),
//        ],
//        ),
//                ),
//
//                ],
//
//              )
//
//            ),
//        );
//        },
    //);
  }
//ListTile(
////            leadin/g:CircleAvatar(
////              backgroundImage: NetworkImage(posts[index]['image']),
////            ),
//leading:  Image(
//image: NetworkImage(posts[index]['image']),
////height:170.0,
////width: 120.0,
//// fit: BoxFit.fill
//fit: BoxFit.cover
//),
//
//title: Text(
//posts[index]['companyName'],
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//subtitle: Text(posts[index]['address']),
//onTap: () => _navigateToPost(context, posts[index]['_id']),
//),


