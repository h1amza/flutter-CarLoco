import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}



List<String> imagePath = [
  "assets/1.jpg",
  "assets/2.jpg",
  "assets/3.jpg",
];
List<String> title = [
  "Welcome to Car's LoCo",
  "Find your favorite car",
  "Get's Started"
];
List<String> description = [
  "Do you need to lease a car? if yes you are in the right way",
  "Use CarLoco to browse and compare leasing deals. Once you've found the perfect deal, contact the dealer for a personalised quote.",
  "Once approved by the leasing the dealer can order your new car."
];


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ContentPage(),
    );
  }
}

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            CarouselSlider(
              autoPlay: false,
              enableInfiniteScroll: false,
              initialPage: 0,
              reverse: false,
              viewportFraction: 1.0,
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              height: MediaQuery.of(context).size.height -30,
              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: AppItro(i),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
    );
  }
}

class AppItro extends StatefulWidget {
  int index;
  AppItro(this.index);
  @override
  _AppItroState createState() => _AppItroState();
}

class _AppItroState extends State<AppItro> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 9,
          child: Image.asset(imagePath[widget.index],
              width: MediaQuery.of(context).size.width
          ),
        ),
        Flexible(
          flex: 1,
            child: Center(
                child: new Text(
                  title[widget.index],
                  style: TextStyle(fontSize: 30),
                )
            ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 25,left: 25),
            child: Center(
                child: Text(description[widget.index],
                  style: TextStyle(color: Colors.grey),
                ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24),
            height: 50,
            child: Stack(
              children: <Widget>[
                Dots(widget.index,3),
                Positioned(
                    right: 0,
                    top:widget.index != 2? 20:0,
                    child: widget.index != 2
                        ? (Text('SCOLL RIGHT'))
                        : LetsGo()
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Dots extends StatefulWidget {
  int index,count;
  Dots(this.index,this.count);
  @override
  _DotsState createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.count,
      itemBuilder: (context, int index) {
        return Container(
            margin: EdgeInsets.only(right: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == widget.index ? Colors.black : Colors.white,
                border: Border.all(color: Colors.black)
            )
        );
      },
    );
  }
}

class LetsGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.lightBlue,
      child: Text(
        "LET'S GO!",
        style: TextStyle(color: Colors.white,fontSize: 18),
      ),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('splash', 'true');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => login(),),
        );
      },
    );
  }
}
