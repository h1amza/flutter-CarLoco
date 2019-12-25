import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_loco/model/carModel.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class JsonAnnonce {

  static List<Car> listDataCar = new List<Car>();
  static List<Car> listDataCarUser = new List<Car>();

  static Future<bool> addAnnonce(
      String model,
      String desc,
      String ville,
      String contact,
      String time,
      String price,
      List<File> imgs,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    String pre=prefs.get('token');
    print('loading...');

    var uri = Uri.parse('https://my-rent-cars-api.herokuapp.com/annonce');

    Map<String,String> he =
    { "Content-type" : "application/json", "auth-token" : "$pre" };

    final request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(he);
    request.fields['model']='$model';
    request.fields['ville']='$ville';

    request.fields['description']='$desc';

    request.fields['phone']='$contact';
    request.fields['timeDisp']=time;
    request.fields['price']=price;

    for(int i=0;i<6;i++){
      if(imgs[i]!=null) {
        var lent = imgs[i].length();
        request.files.add(
          http.MultipartFile(
          'images',
          imgs[i].openRead(),
          await lent,
          filename: basename(imgs[i].path)
          ),
        );
      }
    }

    var response;
    var data;
    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == 200){
      print("Uploaded");
      response = await http.Response.fromStream(streamedResponse);
      data = jsonDecode(response.body);
      bool t = data['success'];print('emmm: ${data['success']}');
      if(t){
        print('${data['annonce']}');
        return true;
      }
    }
    else  print("Filead");
    return false;
  }

  static String urlFiltre="";


  static Future getDataAno()async{
    final prefs = await SharedPreferences.getInstance();
    String pre=prefs.get('token');

    var uri = Uri.parse('https://my-rent-cars-api.herokuapp.com/annonce?$urlFiltre');
    Map<String,String> he ={"Content-type": "application/json","auth-token":"$pre"};
    final request = new http.MultipartRequest("GET", uri);
    request.headers.addAll(he);

    var streamedResponse = await request.send();

    if(streamedResponse.statusCode == 200){
      var response = await http.Response.fromStream(streamedResponse);
      var data = jsonDecode(response.body);
      bool t = data['success'];
      if(t){
        var annonces = data['annonces'];
        listDataCar.clear();
        for (int i = 0; i < annonces.length; i++){
          listDataCar.add(
            Car(
              annonces[i]['model'],
              annonces[i]['description'],
              annonces[i]['ville'],
              annonces[i]['phone'],
              annonces[i]['timeDisp'].toString(),
              annonces[i]['price'].toString(),
              annonces[i]['_id'],
              annonces[i]['images']
            )
          );
        }
        for(int i = 0; i < listDataCar.length; i++){
          print("model ${listDataCar[i].model} image ${listDataCar[i].images.length}");
         // print(listDataCar[i].images.length);
        }
      }
    }
  }

  static Future getDataAnoUser()async{
    final prefs = await SharedPreferences.getInstance();
    String pre=prefs.get('token');

    var uri = Uri.parse('https://my-rent-cars-api.herokuapp.com/annonce/user');
    Map<String,String> he ={"Content-type": "application/json","auth-token":"$pre"};
    final request = new http.MultipartRequest("GET", uri);
    request.headers.addAll(he);

    var streamedResponse = await request.send();

    if(streamedResponse.statusCode == 200){
      var response = await http.Response.fromStream(streamedResponse);
      var data = jsonDecode(response.body);
      bool t = data['success'];
      if(t){
        var annonces = data['annonces'];
        listDataCarUser.clear();
        print("${data['annonces']}");
        for (int i = 0; i < annonces.length; i++){
          listDataCarUser.add(
              Car(
                annonces[i]['model'],
                annonces[i]['description'],
                annonces[i]['ville'],
                annonces[i]['phone'],
                annonces[i]['timeDisp'].toString(),
                annonces[i]['price'].toString(),
                annonces[i]['_id'],
                annonces[i]['images']
              )
          );
        }
      }
    }
  }

  static Future deleteDataAnoUser(String id)async{
    final prefs = await SharedPreferences.getInstance();
    String pre=prefs.get('token');
    String url="https://my-rent-cars-api.herokuapp.com/annonce/$id";
    var uri = Uri.parse('$url');
    Map<String,String> he ={"Content-type": "application/json","auth-token":"$pre"};
    final request = new http.MultipartRequest("DELETE", uri);
    print(uri);
    request.headers.addAll(he);

    var streamedResponse = await request.send();

    if(streamedResponse.statusCode == 200){
      var response = await http.Response.fromStream(streamedResponse);
      var data = jsonDecode(response.body);
      bool t = data['success'];
      if(t){
        getDataAnoUser();
      }
    }
  }


}