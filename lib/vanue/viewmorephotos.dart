import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatelessWidget {


  final String postId;
  final GestureTapCallback onTap;

  GalleryPage({
    Key key,
    this.postId, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venue Photos'),
        backgroundColor: Colors.redAccent[200],
      ),
      // Implemented with a PageView, simpler than setting it up yourself
      // You can either specify images directly or by using a builder as in this tutorial
      body:  FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getVenue(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final  post = json.decode(snapshot.data.bodyString);
            return _buildPost(context,post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


  Widget _buildPost(BuildContext context, post) {
    return Container(
      child: GridView.builder(
        itemCount: post['sub_img'].length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 7.0,
          mainAxisSpacing: 7.0,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GestureDetector(
                onTap: ()=> _navigateToPost(context, post ),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(post['sub_img'][index],
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
            );
        },
      ),

    );
  }



  Widget buildPost(BuildContext context, post, ) {
    return Container(
      child: PhotoViewGallery.builder(
        itemCount: post['sub_img'].length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              post['sub_img'][index],
            ),
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.8,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        loadingChild: Center(
          child: CircularProgressIndicator(),
        ),
      ),

    );
  }

  Widget buildPost1(BuildContext context, post) {
    return      Container(
      child: CarouselSlider(
          items: <Widget>[
      for (var i = 0; i <  post['sub_img'].length; i++)
      Container(

      height: 250.0,
      //   width: 200,
      decoration: BoxDecoration(

        image: DecorationImage(

          image: NetworkImage(post['sub_img'][i]),

          fit: BoxFit.cover,
        ),

        //  borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    ],
    ),
    );
  }










  void _navigateToPost(BuildContext context, post) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => buildPost(context,post)
      ),
    );

  }






}