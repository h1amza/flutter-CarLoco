import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'allCarScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class userProfilePrincipale extends StatelessWidget {
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
  TextEditingController na=new TextEditingController();
  TextEditingController ville=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  String email;
  String url;
  ImageProvider img;
  File _image;
  bool init=false;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      img = Image.file(image).image;
      init=true;
    });
    ProgressDialog pr;
    pr = new ProgressDialog(
        ctx,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600)
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    na.text=Jsondata.user.name;
    email=Jsondata.user.email;
    ville.text=Jsondata.user.city;
    phone.text=Jsondata.user.phone;
    if(Jsondata.user.image != null){
      img = Jsondata.user.image.image;
        url=Jsondata.user.url;
        _image = new File('');
    }
  }
  static BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    ctx=context;
    ProgressDialog pr;
    pr = new ProgressDialog(
        context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => allCar(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back,size: 30,),
        ),
        title: Text('Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.lightBlue,
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
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white70,
                        backgroundImage: _image == null
                            ? (Image.asset('assets/profile.png').image)
                            : (
                            init != true?
                            CachedNetworkImageProvider(url)
                                :
                            (img)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: na,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Full Name',
                          focusColor: Colors.red,
                          hoverColor: Colors.red,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.white30, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.white30, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                              child: Icon(Icons.email),
                            ),
                            Text(email),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: ville,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Ville',
                          focusColor: Colors.red,
                          hoverColor: Colors.red,
                          prefixIcon: Icon(
                            Icons.home,
                            size: 28,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.white30, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.white30, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: phone,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Phone Number',
                          focusColor: Colors.red,
                          hoverColor: Colors.red,
                          prefixIcon: Icon(
                            Icons.phone_iphone,
                            size: 28,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.white30, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.white30, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () async{
                        String name=na.text.toString();
                        String v=ville.text.toString();
                        String p=phone.text.toString();
                        if(name!=''&& v!=''&&p!=''&&name!=null&&v!=null&&p!=null&&_image!=null){
                          pr.show();
                          bool t = await Jsondata.updateinfoUser(name,v, p,_image);
                          pr.hide();
                          if(t){
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
                        }
                        else{
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
                        child: Container(
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
                                Colors.amber[200],
                                Colors.amber[300],
                                Colors.amber[500],
                                Colors.amber[600],
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
}