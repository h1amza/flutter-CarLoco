import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/annonceCarJsondata.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'addAnnonceCar.dart';

class UserAnnonceCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserAnnonce(),
    );
  }
}

class UserAnnonce extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserAnnonce> {

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              Expanded(
                flex: 1,
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 40),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddCarAnnonce(),
                              ),
                            );
                    },
                    child: Container(
                      height: 55,
                      width:250,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: new BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.1, 0.5, 0.7, 0.9],
                          colors: [Colors.orange[800],Colors.orange[500],Colors.orange[500],Colors.orange[800],],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Add New Annonce',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Expanded(
                flex: 10,
                child: ListView.builder(
                  itemCount: JsonAnnonce.listDataCarUser.length,
                  itemBuilder: (context, index) {

                    if (JsonAnnonce.listDataCarUser.length != null ||JsonAnnonce.listDataCarUser.length != 0) {
                      print(JsonAnnonce.listDataCarUser.length);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: Key(JsonAnnonce.listDataCarUser[index].id),
                          background: back(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (d) async {
                            pr.show();
                            await JsonAnnonce.deleteDataAnoUser(
                                JsonAnnonce.listDataCarUser[index].id);
                            await JsonAnnonce.getDataAnoUser();
                            pr.hide();
                            setState(() {
                              JsonAnnonce.getDataAnoUser();
                            });
                            Flushbar(
                              messageText: Center(
                                  child: Text(
                                'Annonce deleted',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                              backgroundColor: Colors.amber,
                              duration: Duration(seconds: 1),
                              leftBarIndicatorColor: Colors.amber,
                              icon: Icon(
                                Icons.announcement,
                                color: Colors.black,
                                size: 25,
                              ),
                            )..show(context);
                          },
                          child: Container(
                            height: 160,
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        print('${JsonAnnonce.listDataCarUser[index].images}');
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            topLeft:  Radius.circular(15),
                                          ),
                                          color: Colors.blue
                                        ),
                                        //color: Colors.redAccent,
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl:JsonAnnonce.listDataCarUser[index].images != null?
                                            (JsonAnnonce.listDataCarUser[index].images.length != 0?
                                            ('http://my-rent-cars-api.herokuapp.com/images/${JsonAnnonce.listDataCarUser[index].images[0]}')
                                                :
                                            ('https://www.enterprise.fr/content/dam/global-vehicle-images/cars/KIA_FORT_2015.png'))
                                            :
                                            "https://www.enterprise.fr/content/dam/global-vehicle-images/cars/KIA_FORT_2015.png"
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
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${JsonAnnonce.listDataCarUser[index].model}',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "${JsonAnnonce.listDataCarUser[index].ville}",
                                              style: TextStyle(
                                                  fontSize: 22, color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                '${JsonAnnonce.listDataCarUser[index].price}',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.indigo[900]),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                '${JsonAnnonce.listDataCarUser[index].numPhone}',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      print('else');
                      return Card(child: Text('Noting to show'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget back() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.red[700], borderRadius: BorderRadius.circular(25)),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}