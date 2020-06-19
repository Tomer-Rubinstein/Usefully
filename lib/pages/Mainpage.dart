import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iusefully/pages/OnBoardPage.dart';
import 'package:iusefully/pages/RewardsPage.dart';

class Mainfile extends StatefulWidget{
  static int currentIndex = 0;

  @override
  _MainfileState createState() => _MainfileState();
}

class _MainfileState extends State<Mainfile> {
  PageController _pageController = PageController(
    initialPage: Mainfile.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    ));

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: Mainfile.currentIndex,
        selectedFontSize: 17,
        unselectedFontSize: 15,
        selectedIconTheme: IconThemeData(
          size: 18,
        ),
        unselectedIconTheme: IconThemeData(
          size: 12
        ),
        selectedItemColor: Color(0xFF5B16D0),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
        unselectedLabelStyle: TextStyle(fontFamily: "NotoSans"),
        elevation: 20,
        items: [
          
          BottomNavigationBarItem(
            title: Text("On Board"),
            icon: Icon(Icons.assignment, size: 38),
          ),
          BottomNavigationBarItem(
            title: Text("Rewards"),
            icon: Icon(Icons.cake, size: 38),
          ),
        ],
        onTap: (index){
          setState(() {
            if (index == 0) {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 450), curve: Curves.ease);
              Mainfile.currentIndex = index;
            }
            if (index == 1) {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 450), curve: Curves.ease);
              Mainfile.currentIndex = index;
            }
          });
        },
      ),
      backgroundColor: Color(0xFF333333),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            Mainfile.currentIndex = index;
          });
        },
        controller: _pageController,
        children: <Widget>[OnBoardPage(), RewardsPage()],
      )
    );
  }
}
