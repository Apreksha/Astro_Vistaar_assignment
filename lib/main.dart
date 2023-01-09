// @dart=2.9

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Feed',
      home: MyFeed(),
    );
  }
}

class MyFeed extends StatefulWidget {
  @override
  _MyFeedState createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  var res;
  List finalList=[];
  Future<void> _launched;
  
  void getResponse()async{
    var response = await Dio().get('https://newsapi.org/v2/everything?q=tesla&from=2021-06-12&sortBy=publishedAt&apiKey=3b7483709f47433ab3fe141e3c4468c3');
    setState(() {
      res=response.data;
    });
  }
Future<void> _launch(String url)async{
    if (await canLaunch(url)){
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String,String>{'header_key':'header_value'}
      );
    }
    else{
      throw 'Could not launch $url';
    }
}
  @override
  void initState(){
    getResponse();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (res == null)?Center(
        child: CircularProgressIndicator(
        ),
      ):Scaffold(
        body: Swiper(
          loop: false,
          scrollDirection: Axis.vertical,
          itemBuilder:(BuildContext context,int index) {
          return SwipeDetector(
            onSwipeRight: (){_launch(res["articles"][index]["url"]);},
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 200,
                      margin: EdgeInsets.only(bottom: 10),
                      //width: MediaQuery.of(context).size.width,
                      child: FadeInImage.assetNetwork(
                        placeholder:"assets/news.jpg",
                          image:res["articles"][index]["urlToImage"])),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 12),
                    child: Text(res["articles"][index]["title"]==null?"author":res["articles"][index]["title"]
                      ,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),),
                  ),
                  //Row(
                    //children: [
                      SizedBox(width: 10),
                      Text(res["articles"][index]["author"]==null?"author":res["articles"][index]["author"]
                        ,style: TextStyle(
                          fontSize: 17
                      ),),
                      //SizedBox(width: MediaQuery.of(context).size.width*0.5),
                      /*Text(res["articles"][index]["publishedAt"].toString().substring(0,10),style: TextStyle(
                          fontSize: 17),
                      textDirection: TextDirection.rtl),*/
                   // ],
                  //),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text(res["articles"][index]["description"]==null?"author":res["articles"][index]["description"]
                      ,style: TextStyle(
                        fontSize: 16
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child: Text(res["articles"][index]["content"]==null?"author":res["articles"][index]["content"]
                      ,style: TextStyle(
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),
          );
            }, itemCount: 19,
      ),)
    );
  }
}

