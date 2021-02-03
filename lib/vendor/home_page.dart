import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';

import 'package:wediina_bussniss/vendor/vendor_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';


import 'package:wediina_bussniss/vendor/single_post_page.dart';


class HomePage extends StatelessWidget {

  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor'),
        backgroundColor: Colors.redAccent[200],
      ),
      body:  _buildBody(context),

    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<PostApiService>(context).getVendors(),
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
    return  AnimationLimiter(
      child: GridView.builder(
        itemCount: posts.length,
          padding: EdgeInsets.all(8),
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 7.0,
      mainAxisSpacing: 7.0,

    ),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 700),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FlipAnimation(
                child: GestureDetector(
                  onTap: () => _navigateToPost(context, posts[index]['_id']),

                  child: Container(
                    height: 100,

                    child: Stack(

                      children: <Widget>[

                        //   margin: Edge//Insets.only(right: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(posts[index]['image'],),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
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
                          child: Text(posts[index]['vendor_cat_name'],
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: TextStyle(color: Colors.white,fontSize: 20,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),



//        child: Card(
//          elevation: 4,
//          child: ListTile(
//            title: Text(
//          posts[index]['vendor_cat_name'],
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          subtitle: Text(posts[index]['vendor_cat_name']),
//          onTap: () => _navigateToPost(context, posts[index]['_id']),
//        ),
//
//
//        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );



      GridView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 7.0,
      mainAxisSpacing: 7.0,

    ),

      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return new GestureDetector(

            onTap: () => _navigateToPost(context, posts[index]['_id']),

              child: Container(
                    height: 100,

                  child: Stack(

                      children: <Widget>[

               //   margin: Edge//Insets.only(right: 10),
                  Container(
               decoration: BoxDecoration(
                   borderRadius:  BorderRadius.circular(10),
                   image: DecorationImage(
                       image: NetworkImage(posts[index]['image'],),
                       fit: BoxFit.fill
                   )
               ),
        ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(10),
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
//                alignment: Alignment.center,
  //         margin: EdgeInsets.only(left:45.0,right:9.0,top: 60.0 ),
                 child: Text(posts[index]['vendor_cat_name'],
                      textAlign: TextAlign.center,
                   maxLines: 3,

                     style: TextStyle(color: Colors.white,fontSize: 20,

                     ),
                   ),
               ),
          ],
        ),



//        child: Card(
//          elevation: 4,
//          child: ListTile(
//            title: Text(
//          posts[index]['vendor_cat_name'],
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          subtitle: Text(posts[index]['vendor_cat_name']),
//          onTap: () => _navigateToPost(context, posts[index]['_id']),
//        ),
//
//
//        ),
        ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(  
        builder: (context) => VendorList(postId: _id),
      ),
    );
  }

//
//  Widget makeItem({image,title}){
//    return AspectRatio(
//      aspectRatio: 1/1,
//      child: Container(
//        height: 100,
//        //   margin: EdgeInsets.only(right: 10),
//        decoration: BoxDecoration(
//            borderRadius:  BorderRadius.circular(10),
//            image: DecorationImage(
//                image: NetworkImage(image),
//                fit: BoxFit.cover
//            )
//        ),
//        child: Container(
//          //padding: EdgeInsets.all(10),
//          decoration: BoxDecoration(
//              borderRadius:  BorderRadius.circular(20),
//              gradient: LinearGradient(
//                   begin: Alignment.bottomRight,
//                  colors: [
//                    Colors.black.withOpacity(.8),
//                    Colors.black.withOpacity(.2),
//
//                  ]
//             )
//          ),
//          child: Align(
//            alignment: Alignment.bottomLeft,
//            child: Text(title,
//              style: TextStyle(color: Colors.white,fontSize: 20),
//
//            ),
//          ),
//        ),
//      ),
//
//    );
//
//  }
}
//
//elevation: 4,
//child: ListTile(
//image
//title: Text(
//posts[index]['image'],
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//subtitle: Text(posts[index]['vendor_cat_name']),
//onTap: () => _navigateToPost(context, posts[index]['_id']),
//),

//Container(
//padding: EdgeInsets.symmetric(horizontal: 20),
//
////          crossAxisAlignment: CrossAxisAlignment.start,
//
//child: ListView(
//scrollDirection: Axis.vertical,
//children: <Widget>[
//makeItem(image: posts[index]['image'] ,title:posts[index]['vendor_cat_name']),
//
//],
//),
//
//
//
//),
//mainAxisAlignment: MainAxisAlignment.center,