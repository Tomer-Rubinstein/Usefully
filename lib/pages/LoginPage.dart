import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iusefully/auth.dart';
import 'package:iusefully/PageSlideAnimation.dart';
import 'package:iusefully/pages/Mainpage.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  

  @override
  Widget build(BuildContext context) {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
    );
    //final animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent
    ));

    return StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            body: Container(
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
            ),),
              child: FadeTransition(
                opacity: controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Welcome!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                            letterSpacing: .6)),
                    SizedBox(height: 6),
                    Text("Please choose an account to sign in with",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: .6), textAlign: TextAlign.center),
                    SizedBox(height: 28),
                    Image.asset("images/login.png", height: 350, width: 350),
                    SizedBox(height: 28),
                    MaterialButton(
                      onPressed: () {
                        authService.googleSignIn().whenComplete((){
                          Route route = PageSlideAnimation(builder: (context) => Mainfile());
                          Navigator.push(context, route);
                        });
                      },
                      shape: StadiumBorder(),
                      color: Colors.white,
                      splashColor: Colors.grey,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset("images/google.png", height: 25, width: 25),
                          SizedBox(width: 4),
                          Text("Sign In",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }else{
          return Container();
        }
      }
    );
  }
}
