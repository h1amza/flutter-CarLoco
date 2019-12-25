import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_car_loco/model/carModel.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../jsondata/annonceCarJsondata.dart';
import 'detailAnnonce.dart';


class content extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return contentscreen();
  }
}
class contentscreen extends StatefulWidget {

  @override
  _contentscreenState createState() => _contentscreenState();
}

class _contentscreenState extends State<contentscreen> {

  String model;
  String ville;
  String price;
  String phone;

  static update()async{
    await JsonAnnonce.getDataAno();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 215,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 5,
            child: ListView.builder(
              itemCount: JsonAnnonce.listDataCar.length,
              itemBuilder: (ctxt, index) {
                  model = JsonAnnonce.listDataCar[index].model;
                  price = JsonAnnonce.listDataCar[index].price.toString();
                  ville = JsonAnnonce.listDataCar[index].ville;
                  phone = JsonAnnonce.listDataCar[index].numPhone;
                return Padding(
                  padding: const EdgeInsets.only(right: 6, left: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>
                          detailAnnonceCar(index),),
                      );
                    },
                    child: Container(
                      height: 160,
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context)
                                    .size
                                    .height,
                                // color: Colors.redAccent,
                                child: Center(
                                  child:/* CachedNetworkImage(
                                    imageUrl: "https://visualhunt.com/photos/1/red-vintage-car-on-street.jpg?s=s",
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),*/
                                  CachedNetworkImage(
                                    imageUrl:JsonAnnonce.listDataCar[index].images != null?
                                    (JsonAnnonce.listDataCar[index].images.length != 0?
                                    ('http://my-rent-cars-api.herokuapp.com/images/${JsonAnnonce.listDataCar[index].images[0]}')
                                        :
                                    ('https://www.enterprise.fr/content/dam/global-vehicle-images/cars/KIA_FORT_2015.png'))
                                        :
                                    "https://www.enterprise.fr/content/dam/global-vehicle-images/cars/KIA_FORT_2015.png"
                                    ,placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    height:MediaQuery.of(context).size.height,
                                    width:MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url,error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context)
                                    .size
                                    .height,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${JsonAnnonce.listDataCar[index].model}',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${JsonAnnonce.listDataCar[index].ville}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment:
                                        Alignment.bottomRight,
                                        child: Text(
                                          '${JsonAnnonce.listDataCar[index].price}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color:
                                              Colors.indigo[900]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Align(
                                        alignment:
                                        Alignment.bottomRight,
                                        child: Text(
                                          '${JsonAnnonce.listDataCar[index].numPhone}',
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
              },
            ),
          ),
        ],
      ),
    );
  }
}