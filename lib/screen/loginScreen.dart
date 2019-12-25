import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'validationNumberScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'allCarScreen.dart';

class login extends StatelessWidget {
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var control;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(400, 70),
                  bottomRight: Radius.elliptical(400, 60),
                ),
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
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.directions_car,
                    size: 180,
                    color: Colors.white,
                  ),
                  Text(
                    "LoCo Car'S",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TabBar(
                  controller: control,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: TabBarView(
                  controller: control,
                  children: <Widget>[Login(), Register()],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => allCar(),),
                );
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Get Started as Guest',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final nameController = TextEditingController();
final emailController = TextEditingController();

class Login extends StatelessWidget {
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
    return Container(
      child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:0,left: 20,right: 20),
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.email,
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
              SizedBox(height: 25,),
              InkWell(
                onTap: () async {
                  String em = emailController.text.toString();
                  if(em==''||em==null){
                    Flushbar(
                      messageText: Center(
                          child: Text('entre a email',
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                      ),
                      backgroundColor: Colors.amber,
                      duration: Duration(seconds: 2),
                      leftBarIndicatorColor: Colors.amber,
                      icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                    )..show(context);
                  }
                  else{
                    pr.show();
                    bool result = await Jsondata.logIn(em);
                    pr.hide();
                    if(result){
                      Jsondata.urlv='https://my-rent-cars-api.herokuapp.com/auth/vlogin';
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => validation(),),
                      );
                    }
                    else{
                      Flushbar(
                        messageText: Center(
                            child: Text('email not register',
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
                child: Container(
                  height: 55,
                  width: 360,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        Colors.blue[300],
                        Colors.blue[400],
                        Colors.blue[500],
                        Colors.blue[600],
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
class Register extends StatelessWidget {
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
    return Container(
      child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:5,left: 20,right: 20),
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
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
              Padding(
                padding: const EdgeInsets.only(top:15,left: 20,right: 20),
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Email',
                    focusColor: Colors.red,
                    hoverColor: Colors.red,
                    prefixIcon: Icon(
                      Icons.mail,
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
              SizedBox(height: 25,),
              InkWell(
                onTap: () async {
                  String em = emailController.text.toString();
                  String name = nameController.text.toString();
                  if(em==null||name==null||em==''||name==''){
                    Flushbar(
                      messageText: Center(
                          child: Text('Name and Email is required ',
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                      ),
                      backgroundColor: Colors.amber,
                      duration: Duration(seconds: 2),
                      leftBarIndicatorColor: Colors.amber,
                      icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                    )..show(context);
                  }
                  else{
                    if(!EmailValidator.validate(em)){
                      Flushbar(
                        messageText: Center(
                            child: Text('form email not valide',
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                        ),
                        backgroundColor: Colors.amber,
                        duration: Duration(seconds: 2),
                        leftBarIndicatorColor: Colors.amber,
                        icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                      )..show(context);
                    }
                    else{
                      pr.show();
                      String result = await Jsondata.signUp(em,name);
                      pr.hide();
                      if(result=='token'){
                        Jsondata.urlv='https://my-rent-cars-api.herokuapp.com/auth/verify';
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => validation(),),
                        );
                      }
                      else{
                        if(result=='this mail already used')
                          Flushbar(
                            messageText: Center(
                                child: Text('this mail already used',
                                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                            ),
                            backgroundColor: Colors.amber,
                            duration: Duration(seconds: 2),
                            leftBarIndicatorColor: Colors.amber,
                            icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                          )..show(context);
                        else Flushbar(
                          messageText: Center(
                              child: Text('Error',
                                style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                          ),
                          backgroundColor: Colors.amber,
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.amber,
                          icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                        )..show(context);
                      }

                    }
                  }
                },
                child: Container(
                  height: 55,
                  width: 360,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        Colors.blue[300],
                        Colors.blue[400],
                        Colors.blue[500],
                        Colors.blue[600],
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
