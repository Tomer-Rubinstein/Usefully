import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iusefully/PageSlideAnimation.dart';
import 'package:iusefully/auth.dart';
import 'package:iusefully/pages/Mainpage.dart';

class AutoLoginPage extends StatefulWidget {
  @override
  _AutoLoginPageState createState() => _AutoLoginPageState();
}

class _AutoLoginPageState extends State<AutoLoginPage> {
  
  @override
  Widget build(BuildContext context) {
    authService.googleSignIn().whenComplete(() {
      Route route = PageSlideAnimation(builder: (context) => Mainfile());
      Navigator.push(context, route);
    });
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            Color(0xFF3594DD),
            Color(0xFF4563DB),
            Color(0xFF5036D5),
            Color(0xFF5B16D0),
          ],
        ),
      ),
      child: SpinKitFadingCube(
        color: Colors.white,
        duration: Duration(milliseconds: 1200),
        size: 78,
      ),
    );
  }
}
