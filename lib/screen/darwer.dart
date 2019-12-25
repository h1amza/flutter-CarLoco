import 'package:flutter/material.dart';
import 'package:flutter_car_loco/jsondata/annonceCarJsondata.dart';
import 'package:flutter_car_loco/jsondata/jsonDataFromApi.dart';
import 'package:flutter_car_loco/screen/userAnnonceCar.dart';
import 'package:flutter_car_loco/screen/userProfilePrincipale.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';
import 'addAnnonceCar.dart';


class Draws extends StatefulWidget {
  @override
  _DrawsState createState() => _DrawsState();
}

class _DrawsState extends State<Draws> {
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

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                String pre = prefs.get('token');
                if (pre != '' && pre != null) {
                  pr.show();
                  bool t = await Jsondata.infoUser(pre);
                  if (t) {
                    pr.hide();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => userProfilePrincipale(),
                      ),
                    );
                  } else {
                    pr.hide();
                    return;
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Let's create your profile with login"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                return Navigator.pop(context);
                              },
                              color: Colors.black,
                            ),
                            FlatButton(
                              color: Colors.amber,
                              child: Text(
                                'okk',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => login(),
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      });
                }
              }),
          //_createDrawerItem(icon: Icons.favorite, text: 'Favorite', onTap: () {}),
          _createDrawerItem(
              icon: Icons.add_box, text: 'Annonces', onTap: () async{
            final prefs = await SharedPreferences.getInstance();
            String pre = prefs.get('token');
            if (pre != '' && pre != null){
              pr.show();
              await JsonAnnonce.getDataAnoUser();
              pr.hide();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAnnonceCar(),
                ),
              );
            }
            else{
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Let's create your Annonce with login first"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            return Navigator.pop(context);
                          },
                          color: Colors.black,
                        ),
                        FlatButton(
                          color: Colors.amber,
                          child: Text(
                            'okk',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => login(),
                              ),
                            );
                          },
                        )
                      ],
                    );
                  }
                  );
            }
          }),
          Divider(),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report, text: 'Report an issue', onTap: () {}),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
  Widget _createHeader() {
    String txt = 'XXX';
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(color: Colors.pink),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.indigo,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "hey dear!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

