import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/screen/userProfile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'allCarScreen.dart';
import 'package:flutter_car_loco/jsondata/annonceCarJsondata.dart';
import 'loginScreen.dart';


class validation extends StatelessWidget {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final codeController=TextEditingController();
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
        body:SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Colors.blue[300],
                  Colors.blue[400],
                  Colors.blue[500],
                  Colors.blue[600],
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child:RichText(
                    text: TextSpan(
                        text: 'Loco',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Car'S",
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 45,
                                fontWeight: FontWeight.bold),
                          ),
                        ]
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:0,left: 20,right: 20),
                        child: TextFormField(
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Code Validation',
                            fillColor: Colors.grey[200],
                            filled: true,
                            prefixIcon: Icon(
                              Icons.code,
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
                      SizedBox(height: 35,),
                      InkWell(
                        onTap: ()async{
                          String co=codeController.text.toString();
                          if(co==''||co==null){
                            Flushbar(
                              messageText: Center(
                                  child: Text('entre a code',
                                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                              ),
                              backgroundColor: Colors.amber,
                              duration: Duration(seconds: 2),
                              leftBarIndicatorColor: Colors.amber,
                              icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                            )..show(context);
                          }else{
                            pr.show();
                            final prefs = await SharedPreferences.getInstance();
                            String token = prefs.get('tokens');
                            bool result = await Jsondata.validCode(co,token);
                            pr.hide();
                            if(result){
                              await JsonAnnonce.getDataAno();
                              if(Jsondata.urlv=='https://my-rent-cars-api.herokuapp.com/auth/vlogin'){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => allCar(),),
                                );
                              }else{
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => userProfile(),),
                                );
                              }
                            }else{
                              Flushbar(
                                messageText: Center(
                                    child: Text('Error code',
                                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                ),
                                backgroundColor: Colors.amber,
                                duration: Duration(seconds: 2),
                                leftBarIndicatorColor: Colors.amber,
                                icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                              )..show(context);
                            }
                          }

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:0,left: 20,right: 20),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  Colors.amber[200],
                                  Colors.amber[300],
                                  Colors.amber[400],
                                  Colors.amber[500],
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => login(),),
                          );
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Entre Number Again',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
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