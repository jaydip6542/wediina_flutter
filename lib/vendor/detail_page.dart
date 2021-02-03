import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:wediina_bussniss/inquery_send/testingv.dart';
import 'package:wediina_bussniss/inquery_send/vendor_inquery.dart';
import 'package:wediina_bussniss/mainscreen/homepage.dart';
import 'package:wediina_bussniss/vanue/vanues.dart';
import 'package:wediina_bussniss/vendor/home_page.dart';
import 'package:wediina_bussniss/vendor/viewmorephotosvendor.dart';
import 'package:wediina_bussniss/vendor/viewmorevideosvedor.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  final String postId;


  const DetailPage({
    Key key,
    this.postId,
  }) : super(key: key);

  @override
  DetailPageState createState() => DetailPageState();

}
  class DetailPageState extends State<DetailPage> {

    int _currentIndex = 2;
    int page = 0;
    ScrollController _scrollController;
    var _isVisible;
    @override
    void initState() {
      super.initState();
      _scrollController = ScrollController();
      _scrollController.addListener(() {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          //  setState(() => _visible = false);

          if(_isVisible)
            setState(() {
              _isVisible = false;
              print("**** $_isVisible up");
            });



        }

        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {

          if(!_isVisible)
            setState(() {
              _isVisible = true;
              print("**** $_isVisible down");
            });



        }
      });
    }




    GlobalKey _bottomNavigationKey = GlobalKey();









  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Vendors Details'),
        backgroundColor: Colors.redAccent[200],
      ),


            body:
            FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getVendoer(widget.postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final  post = json.decode(snapshot.data.bodyString);
            return _buildPost(context,post);
          } else {
            return Center(
              child: GlowingProgressIndicator(
                child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
              ),
            );
          }
         },
      ),



    );
  }
  Widget _buildPost(BuildContext context, post) {


    return ListView(
      controller: _scrollController,
       children: <Widget>[
         Container(
        child: Stack(
            children: <Widget>[
              Container(
                //margin: new EdgeInsets.only(top: 10.0),
                child: CarouselSlider(
                  //width: MediaQuery.of(context).size.width*0.65,

                    items: <Widget>[
                for (var i = 0; i <  post['sub_images'].length; i++)
                Container(

                height: 250.0,
                //   width: 200,
                decoration: BoxDecoration(

                  image: DecorationImage(

                    image: NetworkImage(post['sub_images'][i]),

                    fit: BoxFit.cover,
                  ),

                //  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ],
        ),
         ),

         Container(
           height: 200.0,
           margin: new EdgeInsets.only(left: 10.0,right: 10,top: 170),
           decoration: new BoxDecoration(

             color: Colors.white,
             shape: BoxShape.rectangle,
             borderRadius: new BorderRadius.circular(5.0),
           ),
         ),
    Container(
      margin: new EdgeInsets.only(left: 30.0,right: 10.0,top: 175),
    child: new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(

      width: 250,
      margin:new EdgeInsets.only(left: 16),
      child: Text(post['companyName'],
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 17.0,
            color: Colors.grey[800],
            fontWeight: FontWeight.bold


        ),
      ),
      ),

      Container(height: 10.0,),
      Container(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on,color: Colors.grey[600],size: 16.0,),
        SizedBox(

          width: 250,
          child: Text(post['address'],
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11.0),
          ),
        ),
            ],
        ),
        ),

      Container(height: 5.0,),
      Container(
         child: new Row(
    children: <Widget>[
      Container(
          width: 150,
          child: OutlineButton(
            child: Text('Map',
              textAlign: TextAlign.center,
            ),
            onPressed: () {}, //callback when button is clicked
            borderSide: BorderSide(
              color: Colors.redAccent[100], //Color of the border
              style: BorderStyle.solid, //Style of the border
              width: 0.8, //width of the border
            ),
          )
      ),
    Container(
      margin: new EdgeInsets.only(left: 10.0),
        width: 150,
        child: OutlineButton(
          child: Text('Send Message',
            textAlign: TextAlign.center,
          ),
          onPressed: ()=> _navigateToInquery(context, post['_id'],post['email']), //callback when button is clicked
          borderSide: BorderSide(
            color: Colors.redAccent[100], //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 0.8, //width of the border
          ),
        )
    ),


    ],
        ),
      ),
      Container(height: 5.0,),


      //review and share

      Container(
        child: new Row(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: new Row(
                      children: [
                        Text("3",
                            style: TextStyle(color: Colors.black,fontSize: 12.0)
                        ),
                        Text("Review",
                            style: TextStyle(color: Colors.black,fontSize: 12.0)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 60.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 20.0,
                    width: 50.0,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border,size: 20,),
                      color: Colors.red[500],
                      onPressed: (){
                        





                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text("Shortlist",
                        style: TextStyle(color: Colors.black,fontSize: 12.0)
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 60.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 20.0,
                    width: 50.0,
                    child: IconButton(
                      icon: Icon(Icons.share,size: 20,),
                      color: Colors.black,
                      onPressed: (){
                        Share.share('https://www.wediina.com/VenderDetail/'+ post['_id'], subject: 'Look what I made!');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text("Share",
                        style: TextStyle(color: Colors.black,fontSize: 12.0)
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

     //photos Albems
    Container(
         margin: new EdgeInsets.only(left: 10.0,top: 20),
         child: Text("Album Photos",
    //textAlign: TextAlign.left,
    style: TextStyle(color: Colors.black,fontSize: 18.0)
    ),
         ),

    //photos grideview
    Container(
    margin: new EdgeInsets.only(top: 20),
    child: GestureDetector(
    onTap: () => _navigateToPost(context, post['_id']),




    child: Stack(
    children: <Widget>[
    Container(
    height: 300.0,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 10),
    decoration: new BoxDecoration(

    color: Colors.white,
    shape: BoxShape.rectangle,
    //borderRadius: new BorderRadius.circular(5.0),
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
   height: 250,
    width: 450,
    margin: new EdgeInsets.only(left: 15.0,right: 15,top: 15),
    child: GridView.builder(
    itemCount: post['sub_images'].length,
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 7.0,
    mainAxisSpacing: 7.0,

    ),

    scrollDirection: Axis.vertical,
    itemBuilder: (context, index){
    return Container(
    decoration: BoxDecoration(
    //borderRadius:  BorderRadius.circular(10),

    image: DecorationImage(
    image: NetworkImage(post['sub_images'][index],
    ),
    fit: BoxFit.fill
    )
    ),
    );
      },
    ),
    ),

    Container(
    height: 50.0,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 265),
    child: RaisedButton(
    child: Text('View more '),
    onPressed: ()=> _navigateToPost(context, post['_id']),
    color:  Colors.grey[100], //specify background color  of button from our list of colors
    ),
    ),


    ],
    ),



    ),

    ),




    Container(

    child:post['video_story'].length > 0
    ? Container(
    margin: new EdgeInsets.only(top: 15),
    child: new Column(
    children: <Widget>[
    Container(
    margin: new EdgeInsets.only(left: 10.0,top: 20),
    child: Text("Vidoes",
    //textAlign: TextAlign.left,
    style: TextStyle(color: Colors.black,fontSize: 18.0)
    ),
    ),

    //Vidoes grideview

    Container(
    child: Stack(
    children: <Widget>[
    Container(
    height: 250.0,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 10),
    decoration: new BoxDecoration(

    color: Colors.white,
    shape: BoxShape.rectangle,
    //borderRadius: new BorderRadius.circular(5.0),
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
    height: 200,
    width: 450,
    margin: new EdgeInsets.only(left: 15.0,right: 15,top: 15),
    child: GridView.builder(
    itemCount: post['video_story'].length,
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 7.0,
    mainAxisSpacing: 7.0,

    ),

    scrollDirection: Axis.vertical,
    itemBuilder: (context, index){


    return Container(

//    child: ClipRRect(
//    child: YoutubePlayer(
//    source: post['video_story'][index],
//    quality: YoutubeQuality.HD,
//    aspectRatio: 16/9,
//      showThumbnail: true,
//    context: context,
//    //context: context,
//
//    ),
//    ),
//

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
    ),

    Container(
    height: 50.0,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 215),
    child: RaisedButton(
    child: Text('View more '),
    onPressed: ()=> _navigateToVideos(context, post['_id']),
    color:  Colors.grey[100], //specify background color  of button from our list of colors
    ),
    ),


    ],
    ),
    ),

    ],
    ),
    )
        :
    Container(
    ),
    ),

    //Vidoes



      //Abouts us

    Container(
      //height: 50,
      width: 500,
    margin: new EdgeInsets.only(left: 10.0,top: 20),
    child: new Row(
    children: [
    Text("About ",
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.black,fontSize: 18.0),
    ),
    Text(post['companyName'],
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.black,fontSize: 18.0),
    ),
    ],
    ),
    ),

    Container(
    margin: new EdgeInsets.only(top: 10),
    child: Stack(
    children: <Widget>[
    Container(
    height: 100,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 10),
    decoration: new BoxDecoration(

    color: Colors.white,
    shape: BoxShape.rectangle,
    //borderRadius: new BorderRadius.circular(5.0),
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
       margin: new EdgeInsets.only(left: 15.0,right: 15,top: 15),
    child: Text(post['desp'],
    maxLines: 5,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.black,fontSize: 14.0),
    ),
    ),
    ],
    ),
    ),


    //review

    Container(
    margin: new EdgeInsets.only(left: 10.0,top: 20),
    child: Text("Review",
    //textAlign: TextAlign.left,
    style: TextStyle(color: Colors.black,fontSize: 18.0)
    ),
    ),


    //review gridview
    Container(
    margin: new EdgeInsets.only(top: 20),
    child: Stack(
    children: <Widget>[
    Container(
    height: 400.0,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 10),
    decoration: new BoxDecoration(

    color: Colors.white,
    shape: BoxShape.rectangle,
    //borderRadius: new BorderRadius.circular(5.0),
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
    height: 400,
    width: 450,
    margin: new EdgeInsets.only(left: 15.0,right: 15,top: 15),
    child: GridView.builder(
    itemCount: 6,

    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1,
//    crossAxisSpacing: 7.0,
//    mainAxisSpacing: 7.0,

    ),

    scrollDirection: Axis.vertical,
    itemBuilder: (context, index){
    return  new Stack(

    children: <Widget>[
    Container(
    height: 118.0,
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
    margin: new EdgeInsets.only(left: 15.0,right: 15,top: 15),
    child: Icon(Icons.account_circle,color: Colors.grey[600],size: 40.0,),

    ),

    Container(
    //margin: new EdgeInsets.fromLTRB(120.0, 16.0, 20.0, 16.0),
    margin: new EdgeInsets.only(left: 60.0,right: 5.0),
    constraints: new BoxConstraints.expand(),
    child: new Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Container(
    margin:new EdgeInsets.only(left: 40),
    child: Text("name",
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: 15.0,
    color: Colors.black,
    fontWeight: FontWeight.bold
    ),
    ),
    ),
      Container(
    margin:new EdgeInsets.only(left: 100,right: 10),
    child: Stack(
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

    ),

    ],
    ),
    ),
    ],
    );

    },
    ),
    ),

    Container(
    height: 50.0,
    width: 500,
    margin: new EdgeInsets.only(left: 10.0,right: 10,top: 365),
    child: RaisedButton(
    child: Text('View more '),
    onPressed: (){},
    color:  Colors.grey[100], //specify background color  of button from our list of colors
    ),
    ),


    ],
    ),
    ),






       ],
    );
  }


  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GalleryPagevendor(postId: _id),
      ),
    );
  }


    void _navigateToVideos(BuildContext context, String _id) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideosPagevendor(postId: _id),
        ),
      );
    }







    void _navigateToInquery(BuildContext context, String _id,String email) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Vendor_Inquerytesting(postId: _id, Email:email),
        ),
      );
      print(_id);
    }








//////


}