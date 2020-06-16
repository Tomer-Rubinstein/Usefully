import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iusefully/auth.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();


class ToDoCard extends StatelessWidget{
  final String title;
  final String content;
  static int _index = 0;

  ToDoCard({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: UniqueKey(),
      onDismissed: (direction){
        for(int x=0; x < titles.length; x++){
          if(titles[x] == title){
            _index = x;
          }
        }
        titles.removeAt(_index);
        contents.removeAt(_index);
        showDialog(
          context: context,
          child: AlertDialog(
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 12),
                    Text("Well Done!", style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSans",
                      fontSize: 26
                    )),
                    SizedBox(height: 8),
                    Text("You've completed a task! Here's your reward:", style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSans",
                      fontSize: 18
                    ), textAlign: TextAlign.center),
                    SizedBox(height: 16),
                    Text(rewards[_index ?? 0].toString(), style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSans",
                      fontSize: 24
                    ), textAlign: TextAlign.center,),
                  ],
                ),
              ),
            )
        );
        rewards.removeAt(_index);
        authService.createNewTask(user);
        
      },
      background: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text("Swipe to Finish", style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              )),
              Spacer(),
              Icon(Icons.done, color: Colors.white, size: 36,)
            ],
          ),
        ),
      ),
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 0)
            )
          ]
        ),
        
        child: Padding(
          padding: const EdgeInsets.only(right: 22, left: 22, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Text(title, style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontFamily: "NotoSans"
              ), textAlign: TextAlign.center,),

              SizedBox(height: 12),

              Text(content, style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 17,
                fontFamily: "NotoSans"
              ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.visible,
              )
            ],
          ),
        ),
      ),
    );
  }
}
