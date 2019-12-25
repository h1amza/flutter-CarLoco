import 'package:flutter/material.dart';
import 'package:flutter_car_loco/screen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allCarScreen.dart';
import '../jsondata/annonceCarJsondata.dart';
import 'loginScreen.dart';

class MyApp extends StatelessWidget {
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
   Future checkDirectionRoute() async {
     final prefs = await SharedPreferences.getInstance();

     String content1=prefs.get('splash');
     String content2=prefs.get('token');

     if(content1=='' || content1==null){
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => splash(),),
       );
     }
     else{
       if(content2==''||content2==null){
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => login(),),
         );
       }
       else{
         await JsonAnnonce.getDataAno();
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => allCar(),),
         );
       }
     }
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
    checkDirectionRoute();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.blue[100],
              Colors.blue[200],
              Colors.blue[300],
              Colors.blue[400],
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.directions_car,
                size: 200,
                color: Colors.white,
              ),
              SizedBox(height: 25,),
              Text(
                "LoCo Car's",
                style: TextStyle(color: Colors.white,fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
