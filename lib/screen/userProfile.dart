import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'allCarScreen.dart';

class userProfile extends StatelessWidget {
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
  TextEditingController ville = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height+90,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Colors.black,
                      backgroundImage: _image == null?
                      (Image.asset('assets/profile.png').image)
                          :
                      (Image.file(_image).image),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
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
                              borderSide:
                              const BorderSide(color: Colors.white30, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.white30, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          controller: phone,
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
                              borderSide:
                              const BorderSide(color: Colors.white30, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.white30, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      InkWell(
                        onTap: ()async{
                          String v=ville.text.toString();
                          String p=phone.text.toString();
                          if(v!=null&&v!=''&&p!=null&&p!=''){
                            File img;
                            bool t;
                            pr.show();
                            if(_image==null)
                              {
                                t = await Jsondata.updateinfoUser('', v, p,img);
                                pr.hide();
                              }
                            else
                              {
                                t = await Jsondata.updateinfoUser('', v, p, _image);
                                pr.hide();
                              }
                            if(t){
                              print('wala');
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
                              await Future.delayed(Duration(seconds: 3));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => allCar(),),
                              );
                            }
                            else {
                              Flushbar(
                                messageText: Center(
                                    child: Text('Error',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),)
                                ),
                                backgroundColor: Colors.amber,
                                duration: Duration(seconds: 1),
                                leftBarIndicatorColor: Colors.amber,
                                icon: Icon(
                                  Icons.announcement, color: Colors.black,
                                  size: 25,),
                              )..show(context);
                            }
                          }
                          else{
                            Flushbar(
                              messageText: Center(
                                  child: Text('entre data',
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),)
                              ),
                              backgroundColor: Colors.amber,
                              duration: Duration(seconds: 1),
                              leftBarIndicatorColor: Colors.amber,
                              icon: Icon(
                                Icons.announcement, color: Colors.black,
                                size: 25,),
                            )..show(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30,left: 30),
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
                                'SUBMIT',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}