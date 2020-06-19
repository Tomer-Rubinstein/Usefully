import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';
import 'package:iusefully/Ticket/Ticket_Chip.dart';
import 'package:iusefully/auth.dart';
import 'package:iusefully/widgets/CustomDialog.dart';
import 'package:iusefully/widgets/styles.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:provider/provider.dart';

List<String> chipTitles = ["Sport", "School", "Mission", "Contact"];

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final _random = new Random();

  List<String> randomActivity(var activities){
    int index = _random.nextInt(activities.length);
    var title = activities.keys.toList()[index];
    var content = activities.values.toList()[index];
    return [title, content];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          if(chipTitles.isNotEmpty){
            print("hey: $chipTitles");
            var title = chipTitles[_random.nextInt(chipTitles.length)];
            var result = [];
            if(title == "Sport"){
              var activities = {
                "20 Push Ups": "Go down for 20!",
                "Walk": "Go out for a 15 minutes walk",
                "50 Jumps": "Standing still jumping",
              };
              result = randomActivity(activities);
              
            }

            if(title == "School"){
              var activities = {
                "Home Work": "Are you sure you have no homework left?",
                "Learn": "Study for an upcoming exam",
                "Learn A New Language": "Study a foreign language for 30 minutes",
                "Research": "Research about something that interested you",
              };
              result = randomActivity(activities);
            }

            if(title == "Mission"){
              var activities = {
                "Go For It!": "Start something that you never started!",
                "Read": "Read a short article about a subject that you like",
                "Clean": "Clean your environment",
                "No Junk Food": "Do not eat junk food for one day",
                "Meditation": "Meditate for 7 minutes",
                "New Skill": "Teach yourself a new skill"
              };
              result = randomActivity(activities);
            }

            if(title == "Contact"){
              var activities = {
                "Make a Call": "Call to one of your close ones",
                "Invite a Friend": "Invite over one of your friends",
              };
              result = randomActivity(activities);
            }

            titles.add(result[0]);
            contents.add(result[1]);
            List<String> _customRewards = ["Do nothing for 10 minutes.", "Do one of your hobbies for 30 minutes", "1 Episode of Favorite TV Show", "Eat your favorite meal"];
            String reward = _customRewards[_random.nextInt(_customRewards.length)];
            rewards.add(reward);
            chipTitles = ["Sport", "School", "Mission", "Contact"];
            authService.createNewTask(user);

            Navigator.of(context).pop();
          }else{
            showDialog(context: context, builder: (BuildContext context) => CustomDialog(title: "Invalid Action", content: "Please specify at least one category from this chips above",));
          }

        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 28,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: Styles.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Text("Ticket", style: Styles.title),
                SizedBox(height: 10),
                Text(
                    "Feel like you didn't do anything productive today? Take a ticket, and complete a task",
                    style: Styles.content,
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 28,
                          ),
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context) => CustomDialog(title: "Help", content: "You can click the chips to remove them from the process of generating a random task. Keep in mind that you must leave at least one chip available.",));
                          }),
                    ),
                    Container(),
                    Container(),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10);
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: chipTitles.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TicketChip(title: chipTitles[index]);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Image.asset("images/ticket_pic.png"),
                SizedBox(height: 20),
                Text("Go Ahead", style: Styles.title),
                Text(
                  "And generate a random task based on the chips above\n",
                  style: Styles.content,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
