import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_loco/model/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jsondata{
 //String email;
 //String name;
 //Jsondata(this.email,this.name);


 static String urlv='';

 static Future<String> signUp(String em,String na) async {
     String url='https://my-rent-cars-api.herokuapp.com/auth/send';
     Map<String,String> he={"Content-type": "application/json"};
     String json = '{"email": "$em", "name": "$na"}';

     http.Response r = await http.post('$url', headers: he, body: json);

     var data = jsonDecode(r.body);//print(data);
     bool t = data['success'];

     if(t != false){
       final prefs = await SharedPreferences.getInstance();
       prefs.setString('tokens', data['token']);

       return 'token';
     }
     else{
       if(data['error']=='this mail already used') {
         return 'this mail already used';
       }
       else {
         return data['error'];
       }
     }
   }
 static Future<bool> logIn(String em) async {
   String url='https://my-rent-cars-api.herokuapp.com/auth/login';
   Map<String,String> he={"Content-type": "application/json"};
   String json = '{"email": "$em"}';

   http.Response r = await http.post('$url', headers: he, body: json);

   var data = jsonDecode(r.body);//print(data);
   bool t = data['success'];

   if(t){
     final prefs = await SharedPreferences.getInstance();
     prefs.setString('tokens', data['token']);
     return true;
   }
   else{
     return false;
   }
 }
   static Future<bool> validCode(String co,String tok) async {
     String url=urlv;
     Map<String,String> he={"Content-type": "application/json"};
     String json = '{"token": "$tok", "code": "$co"}';

     http.Response r = await http.post('$url', headers: he, body: json);

     var data = jsonDecode(r.body);print(data);
     bool t = data['success'];

     if(!t){
       return false;
     }
     else{
       final prefs = await SharedPreferences.getInstance();
       prefs.setString('token',data['token']);
       return true;
     }
   }
 static User user;
 static Future<bool> infoUser(String pre) async {

   String url='https://my-rent-cars-api.herokuapp.com/user';
   Map<String,String> he={"Content-type": "application/json","auth-token":"$pre"};

   http.Response r = await http.get('$url', headers: he);

   var data = jsonDecode(r.body);
   print(data['user']['image']);
   bool t = data['success'];
   if(t){
   if(data['user']['image']==null)
     user = new User(
         data['user']['name'],
         data['user']['email'],
         data['user']['city'],
         data['user']['phone'],
         null,
         null
     );
   else
     user = new User(
       data['user']['name'],
       data['user']['email'],
       data['user']['city'],
       data['user']['phone'],
       Image.network("http://my-rent-cars-api.herokuapp.com/images/${data['user']['image']}"),
       "http://my-rent-cars-api.herokuapp.com/images/${data['user']['image']}"
     );
     return true;
   }else{
     return false;
   }
 }
 static Future<bool> updateinfoUser(String na,String vil,String phone,File img) async {
   final prefs = await SharedPreferences.getInstance();
   String pre=prefs.get('token');
   //print('loading...');
   var uri = Uri.parse('https://my-rent-cars-api.herokuapp.com/user');
   Map<String,String> he={"Content-type": "application/json","auth-token":"$pre"};
   final request = new http.MultipartRequest("POST", uri);
   if(na!=null&&na!="")request.fields['name']='$na';
   request.fields['city']='$vil';
   request.fields['phone']='$phone';
   request.headers.addAll(he);
   //print(img);
   if(img != null &&img.path != ''){
       var lent = img.length();
       request.files.add(
         http.MultipartFile(
           'image',
           img.openRead(),
           await lent,
           filename: basename(img.path),
         ),
       );
   }
   var response;
   var data;
   var streamedResponse = await request.send();
   if(streamedResponse.statusCode == 200){
     //print("Uploaded");
     response = await http.Response.fromStream(streamedResponse);
     data = jsonDecode(response.body);
     //print(data['user']['image']);
     bool t = data['success'];
     if(t){
       user = new User(
         data['user']['name'],
         data['user']['email'],
         data['user']['city'],
         data['user']['phone'],
         Image.network("http://my-rent-cars-api.herokuapp.com/images/${data['user']['image']}"),
         "http://my-rent-cars-api.herokuapp.com/images/${data['user']['image']}"
       );
       //infoUser(pre);
       return true;
     }
     else return false;
   }
   else print("Failed");
   return false;
 }

}
