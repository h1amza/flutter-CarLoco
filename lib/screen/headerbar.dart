import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/annonceCarJsondata.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';
import 'package:flutter_car_loco/screen/allCarScreen.dart';

class headerbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bar();

  }
}
class bar extends StatefulWidget {
  @override
  _barState createState() => _barState();
}

class _barState extends State<bar> {

  TextEditingController modelC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController minC = TextEditingController();
  TextEditingController maxC = TextEditingController();

  String check(){
    String filtre = "";
    String model = modelC.text.toString();
    String city = cityC.text.toString();
    String min = minC.text.toString();
    String max = maxC.text.toString();

    if(max ==''&& model==''&& city=="" && min=='') return filtre ="";
    if(max ==''&& model==''&& city=="" && min!='') return filtre="min=$min";
    if(max ==''&& model==''&& city!="" && min=='') return filtre="ville=$city";
    if(max ==''&& model==''&& city!="" && min!='') return filtre="ville=$city&min=$min";
    if(max ==''&& model!=''&& city=="" && min=='') return filtre="model=$model";
    if(max ==''&& model!=''&& city=="" && min!='') return filtre="model=$model&min=$min";
    if(max ==''&& model!=''&& city!="" && min=='') return filtre="model=$model&ville=$city";
    if(max ==''&& model!=''&& city!="" && min!='') return filtre="model=$model&ville=$city&min=$min";

    if(max !=''&& model==''&& city=="" && min=='') return filtre ="max=$max";
    if(max !=''&& model==''&& city=="" && min!='') return filtre="min=$min&max=$max";
    if(max !=''&& model==''&& city!="" && min=='') return filtre="ville=$city&max=$max";
    if(max !=''&& model==''&& city!="" && min!='') return filtre="ville=$city&min=$min&max=$max";
    if(max !=''&& model!=''&& city=="" && min=='') return filtre="model=$model&max=$max";
    if(max !=''&& model!=''&& city=="" && min!='') return filtre="model=$model&min=$min&max=$max";
    if(max !=''&& model!=''&& city!="" && min=='') return filtre="model=$model&ville=$city&max=$max";
    if(max !=''&& model!=''&& city!="" && min!='') return filtre="model=$model&ville=$city&min=$min&max=$max";

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
    return Container(
      height: 210,
      color: Colors.blue[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.blue[900],
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: IconButton(
                          onPressed: () async {
                            final prefs =
                            await SharedPreferences.getInstance();
                            String pre = prefs.get("token");
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: (pre != '' && pre != null)
                                        ? Text('Log out?')
                                        : Text('Return to login?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          return Navigator.pop(
                                              context);
                                        },
                                        color: Colors.black,
                                      ),
                                      FlatButton(
                                        color: Colors.black,
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          prefs.setString(
                                              'token', '');
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  login(),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.phonelink_erase,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: "Find",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: " Car's",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          controller: modelC,
                          decoration: InputDecoration(
                            hintText: "Model",
                            fillColor: Colors.grey[300],
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: ()async{
                                String filtre ="";
                                pr.show();
                                if(modelC.text.toString()!='' && modelC.text.toString()!=null)
                                  filtre="model=${modelC.text.toString()}";
                                pr.show();
                                JsonAnnonce.urlFiltre = filtre;
                                await JsonAnnonce.getDataAno();
                                pr.hide();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        allCar(),
                                  ),
                                );

                              },
                              icon: Icon(Icons.send),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 100.0),
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    title: Text(
                                        'Choise Your Filtre Search'),
                                    content: StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextField(
                                            controller: cityC,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: ()async{
                                                  String filtre ="";
                                                  pr.show();
                                                  if(modelC.text.toString()!='' && modelC.text.toString()!=null)
                                                    filtre="model=${modelC.text.toString()}";
                                                  if(cityC.text.toString()!='' && cityC.text.toString()!=null)
                                                    if(modelC.text.toString()!='' && modelC.text.toString()!=null)
                                                    filtre="$filtre&ville=${cityC.text.toString()}";
                                                    else filtre="${filtre}ville=${cityC.text.toString()}";
                                                   JsonAnnonce.urlFiltre = filtre;
                                                      await JsonAnnonce.getDataAno();
                                                  pr.hide();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          allCar(),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.send),
                                              ),
                                              hintText: 'City',
                                            ),
                                          ),
                                          TextField(
                                            controller: minC,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  onPressed: ()async{
                                                    JsonAnnonce.urlFiltre = check();
                                                    pr.show();
                                                      await JsonAnnonce.getDataAno();
                                                    pr.hide();
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            allCar(),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.send),
                                                ),
                                                hintText: 'Min price'
                                            ),
                                          ),
                                          TextField(
                                            controller: maxC,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  onPressed: ()async{
                                                    JsonAnnonce.urlFiltre = check();
                                                    pr.show();
                                                      await JsonAnnonce.getDataAno();
                                                    pr.hide();
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            allCar(),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.send),
                                                ),
                                                hintText: 'Max price'
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 55,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            new BorderRadius.circular(15),
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
                              'Filtre',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
