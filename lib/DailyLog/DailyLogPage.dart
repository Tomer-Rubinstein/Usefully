import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iusefully/DailyLog/DailyLogCard.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';
import 'package:iusefully/widgets/styles.dart';
import 'package:provider/provider.dart';

class DailyLogPage extends StatelessWidget {
  static int _length = 0;
  static int _index = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          var user = Provider.of<FirebaseUser>(context);
          if (snapshot.hasData) {
            // void findUser(length) {
            //   for (int i = 0; i < length; i++) {
            //     if (user.uid == snapshot.data.documents[i]["uid"]) {
            //       log_rewards = new List<String>.from(snapshot.data.documents[_index]["log_rewards"]);
            //       log_titles = new List<String>.from(snapshot.data.documents[_index]["log_titles"]);
            //     }
            //   }
            // }

            // Firestore.instance
            //     .collection('users')
            //     .getDocuments()
            //     .then((theDocuments) {
            //   _length = theDocuments.documents.length;
            // }).whenComplete(() {
            //   findUser(_length);
            // });

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
                      SizedBox(height: 10),
                      Image.asset("images/daily-log.png",
                          width: 290, height: 290),
                      SizedBox(height: 10),
                      Container(
                        height: 280,
                        width: double.infinity,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            DailyLogCard("Completed Tasks", log_titles, log_rewards, true),
                            SizedBox(width: 15),
                            DailyLogCard("Rewards Consumed", log_titles, log_rewards, false),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ));
          } else {
            return Container();
          }
        });
  }
}
