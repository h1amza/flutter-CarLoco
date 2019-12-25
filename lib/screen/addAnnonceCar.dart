import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/annonceCarJsondata.dart';
import 'package:flutter_car_loco/screen/splashScreen.dart';
import 'package:flutter_car_loco/screen/userAnnonceCar.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddCarAnnonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController model = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  TextEditingController ville = new TextEditingController();
  TextEditingController con = new TextEditingController();
  TextEditingController time = new TextEditingController();
  TextEditingController price = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static BuildContext ctx;
  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: ()async{
            pr.show();
            await JsonAnnonce.getDataAnoUser();
            pr.hide();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserAnnonceCar(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back,size: 30,),
        ),
        title: Text('Annonce'),
        centerTitle: true,
      ),
      // backgroundColor: Colors.blue[900],
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
                   // SizedBox(height: 50,),
                    Container(
                      //color: Colors.deepOrange,
                      height: MediaQuery.of(context).size.height / 2.2,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child:ImageContent(),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          txtField(
                            model,TextInputType.text, 'Model', Icon(
                              Icons.directions_car, size: 28, color: Colors.black,),
                          ),
                          txtField(
                            desc, TextInputType.text, 'description', Icon(
                              Icons.text_fields, size: 28, color: Colors.black,),
                          ),
                          txtField(
                            ville,TextInputType.text, 'ville',Icon(
                              Icons.panorama, size: 28, color: Colors.black,),
                          ),
                          txtField(
                            con, TextInputType.phone, 'Contact', Icon(
                              Icons.phone, size: 28, color: Colors.black,),
                          ),
                          txtField(
                            time, TextInputType.datetime, 'time free', Icon(
                              Icons.date_range, size: 28, color: Colors.black,),
                          ),
                          txtField(
                            price, TextInputType.number, 'Price', Icon(
                              Icons.attach_money, size: 28, color: Colors.black,),
                          ),
                          SizedBox(height: 25,),
                          InkWell(
                            onTap: ()async{
                              String m = model.text.toString(),
                                  d = desc.text.toString(),
                                  v = ville.text.toString(),
                                  ph = con.text.toString(),
                                  t = time.text.toString(),
                                  p = price.text.toString();
                              if((d!="" && v!="" && ph!="" && t!="" && p!="")){
                                pr.show();
                                bool resulta = await JsonAnnonce.addAnnonce(m,d,v,ph,t,p,images);
                                pr.hide();
                                if(resulta){
                                  Flushbar(
                                    messageText: Center(
                                        child: Text('Greate',
                                          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                    ),
                                    backgroundColor: Colors.amber,
                                    duration: Duration(seconds: 1),
                                    leftBarIndicatorColor: Colors.amber,
                                    icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                                  )..show(context);
                                }
                                else{
                                  Flushbar(
                                    messageText: Center(
                                        child: Text('Error',
                                          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                    ),
                                    backgroundColor: Colors.amber,
                                    duration: Duration(seconds: 1),
                                    leftBarIndicatorColor: Colors.amber,
                                    icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                                  )..show(context);
                                }
                              }else{
                                Flushbar(
                                  messageText: Center(
                                      child: Text('entre data',
                                        style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                  ),
                                  backgroundColor: Colors.amber,
                                  duration: Duration(seconds: 1),
                                  leftBarIndicatorColor: Colors.amber,
                                  icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                                )..show(context);
                              }
                              },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30, left: 30),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 55,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: new BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        stops: [0.1, 0.5, 0.7, 0.9],
                                        colors: [
                                          Colors.orange[300],
                                          Colors.orange[500],
                                          Colors.orange[700],
                                          Colors.orange[900],
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'ADD',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  Widget txtField(TextEditingController txtC,TextInputType txtI,String txtH, Icon ic){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: TextFormField(
        controller: txtC,
        style: TextStyle(color: Colors.black),
        keyboardType: txtI,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          hintText: txtH,
          focusColor: Colors.red,
          hoverColor: Colors.red,
          prefixIcon: ic,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white30, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white30, width: 1.0),
          ),
        ),
      ),
    );
  }
}

class ImageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Imagecontent();
  }
}
class Imagecontent extends StatefulWidget {
  @override
  _ImagecontentState createState() => _ImagecontentState();
}
List <File> images =new List(6);
class _ImagecontentState extends State<Imagecontent> {



  Future<File> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("image: $image");
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       // color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount:6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (content,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                  child:
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[200],
                        child: InkWell(
                          onTap: ()async{
                            File img = await getImage();
                            print(img);
                            if(img!=null){
                              setState(() {
                                images[index]=img;
                              });
                            }
                          },
                          child:
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image(
                                      image: images[index] == null
                                          ?
                                      (Image.asset('assets/add.png').image)
                                      :
                                      //(Image.asset('assets/2.jpg').image)
                                      (Image.file(images[index]).image),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Positioned(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    bottom: 5,
                                    left: 25,
                                    child: Dots(index,6),
                                  ),
                                ],
                              ),
                        ),
                ),
                     // Dots(index)
              );
            }
        )
    );
  }
}