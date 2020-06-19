import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iusefully/DailyLog/DailyLogCard.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';
import 'package:iusefully/auth.dart';
import 'package:iusefully/widgets/styles.dart';
import 'package:provider/provider.dart';

class DailyLogPage extends StatefulWidget {
  @override
  _DailyLogPageState createState() => _DailyLogPageState();
}

class _DailyLogPageState extends State<DailyLogPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    ));
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: Styles.backgroundGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Text("Log", style: Styles.title),
              Text(
                "Check it out! Here's what you've accomplished so far",
                style: Styles.content,
                textAlign: TextAlign.center,
              ),
              Image.asset("images/login-pic.png", width: 250, height: 250),
              MaterialButton(
                color: Colors.white,
                onPressed: (){
                  setState(() {
                    log_titles.clear();
                    log_rewards.clear();
                    authService.createNewTask(user);
                  });
                },
                splashColor: Colors.grey,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.delete),
                    SizedBox(width: 3),
                    Text("Clear", style: TextStyle(fontFamily: "NotoSans", fontSize: 18)),
                  ],
                ),
                shape: StadiumBorder(),
              ),
              SizedBox(height: 6),
              Container(
                height: 280,
                width: double.infinity,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    DailyLogCard(
                        "Completed Tasks", log_titles, log_rewards, true),
                    SizedBox(width: 15),
                    DailyLogCard(
                        "Rewards Consumed", log_titles, log_rewards, false),
                  ],
                ),
              ),
              SizedBox(height: 6),
              
            ],
          ),
        ),
      ),
    ));
  }
}
