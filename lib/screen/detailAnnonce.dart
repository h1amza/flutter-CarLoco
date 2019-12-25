import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/annonceCarJsondata.dart';
import 'package:flutter_car_loco/screen/splashScreen.dart';
import 'package:flutter_car_loco/screen/userAnnonceCar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class detailAnnonceCar extends StatelessWidget {
  int index;
  detailAnnonceCar(this.index);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(index),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int indis;
  MyHomePage(this.indis);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String model;
  String desc;
  String ville;
  String con;
  String time;
  String price;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = JsonAnnonce.listDataCar[widget.indis].model;
    desc = JsonAnnonce.listDataCar[widget.indis].desc;
    ville = JsonAnnonce.listDataCar[widget.indis].ville;
    con = JsonAnnonce.listDataCar[widget.indis].numPhone;
    time = JsonAnnonce.listDataCar[widget.indis].time;
    price = JsonAnnonce.listDataCar[widget.indis].price;
  }

  static BuildContext ctx;
  @override
  Widget build(BuildContext context) {

    int imagesLength = JsonAnnonce.listDataCar[widget.indis].images.length;
    print(imagesLength);
    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Container(
                      //color: Colors.deepOrange,
                      height: MediaQuery.of(context).size.height / 2.2,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child:ImageContent(widget.indis,imagesLength),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          containerTxt(model,Icon(
                            Icons.directions_car, size: 28, color: Colors.black,),
                          ),
                          containerTxt(desc,Icon(
                            Icons.text_fields, size: 28, color: Colors.black,),
                          ),
                          containerTxt(ville,Icon(
                            Icons.map, size: 28, color: Colors.black,),
                          ),
                          containerTxt(con,Icon(
                            Icons.phone, size: 28, color: Colors.black,),
                          ),
                          containerTxt(time,Icon(
                            Icons.access_time, size: 28, color: Colors.black,),
                          ),
                          containerTxt(price,Icon(
                            Icons.attach_money, size: 28, color: Colors.black,),
                          ),
                          SizedBox(height: 25,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerTxt(String txtC, Icon ic){
   return
     Padding(
       padding: const EdgeInsets.fromLTRB(25,10,25,10),
       child: Container(
         height: 58,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
             borderRadius: new BorderRadius.only(
               topLeft:  const  Radius.circular(15.0),
               topRight: const  Radius.circular(15.0),
               bottomRight:  const  Radius.circular(15.0),
               bottomLeft: const  Radius.circular(15.0),
             ),
             color: Colors.grey[200]
         ),
         child: Row(
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(left: 10,right: 15),
               child: ic,
             ),
             Text(txtC),
           ],
         ),
       ),
     );
  }
}

class ImageContent extends StatelessWidget {
  int indiss;
  int images;
  ImageContent(this.indiss,this.images);
  @override
  Widget build(BuildContext context) {
    return Imagecontent(indiss,images);
  }
}
class Imagecontent extends StatefulWidget {
  int indiss;
  int images;
  Imagecontent(this.indiss,this.images);
  @override
  _ImagecontentState createState() => _ImagecontentState();
}
class _ImagecontentState extends State<Imagecontent> {

  @override
  Widget build(BuildContext context) {

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Swiper(
          itemCount: widget.images!=0?widget.images:1,
          itemWidth: 300,
          viewportFraction: 0.8,
          scale: 0.9,
          itemBuilder: (BuildContext context, int index) {
            int r = widget.indiss;
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(35),
              ),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: CachedNetworkImage(
                      imageUrl:
                      JsonAnnonce.listDataCar[widget.indiss].images !=null?
                  (JsonAnnonce.listDataCar[widget.indiss].images.length != 0?
                  ("http://my-rent-cars-api.herokuapp.com/images/${JsonAnnonce.listDataCar[widget.indiss].images[index]}")
                    :
                  ('https://www.google.com.tr/imgres?imgurl=https%3A%2F%2Fimg.icons8.com%2Fcotton%2F2x%2Ferror.png&imgrefurl=https%3A%2F%2Ficons8.com%2Ficon%2F360%2Ferror&docid=0c5OFfY27naGmM&tbnid=h8bULkmhLrM1-M%3A&vet=10ahUKEwiDg_PXss_mAhVBilwKHaocBmYQMwhNKAMwAw..i&w=256&h=256&client=opera&bih=794&biw=1496&q=error%20icon&ved=0ahUKEwiDg_PXss_mAhVBilwKHaocBmYQMwhNKAMwAw&iact=mrc&uact=8'))                          :
                      ('data:image/png;base64,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')
                      ,placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      height:
                      MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      errorWidget: (context, url,error) =>
                          Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    bottom: 5,
                    left: 25,
                    child: Dots(index,widget.images),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
