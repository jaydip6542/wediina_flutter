import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideosPagevanu extends StatelessWidget {


  final String postId;
  final GestureTapCallback onTap;

  VideosPagevanu({
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
        itemCount: post['video_story'].length,
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
              child:YoutubePlayer(
                controller: YoutubePlayerController(

                  initialVideoId: YoutubePlayer.convertUrlToId(post['video_story'][index]),
                  //initialVideoId: post['video_story'][index],
                  flags: YoutubePlayerFlags(
                    mute: false,
                    autoPlay: false,
                    //forceHideAnnotation: true,
                  ),
                ),
                showVideoProgressIndicator: true,
              ),
            );
        },
      ),

    );
  }

}