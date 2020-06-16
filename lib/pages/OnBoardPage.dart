import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';
import 'package:iusefully/PageSlideAnimation.dart';
import 'package:iusefully/Ticket/Ticket_Page.dart';
import 'package:iusefully/ToDoCard.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OnBoardPage extends StatefulWidget{

  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int _length = 0;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
 
    
    var user = Provider.of<FirebaseUser>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          void findUser(length){
            for(int i=0; i < length; i++){
              if(user.uid == snapshot.data.documents[i]["uid"]){
                _index = i;
                titles = new List<String>.from(snapshot.data.documents[_index]["titles"]);
                contents = new List<String>.from(snapshot.data.documents[_index]["contents"]);
                rewards = new List<String>.from(snapshot.data.documents[_index]["rewards"]);
              }
            }
          }
          Firestore.instance.collection('users').getDocuments().then((theDocuments) {
            _length = theDocuments.documents.length;
          }).whenComplete(() {
            findUser(_length);
          });
        return Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Tooltip(
                  message: "Random Task",
                  child: MaterialButton(
                    onPressed: (){
                      Route route = PageSlideAnimation(builder: (context) => TicketPage());
                      Navigator.push(context, route);
                    },
                    color: Color(0xFF5036D5),
                    elevation: 5,
                    splashColor: Colors.white,
                    shape: StadiumBorder(),
                    child: Text("Ticket", style: TextStyle(
                      fontSize: 18,
                      fontFamily: "RobotoMono",
                      color: Colors.white
                    )),
                  ),
                ),
              ),
              Container(),
              Tooltip(
                message: "New Task",
                child: MaterialButton(
                  onPressed: (){
                    Route route = PageSlideAnimation(builder: (context) => NewTaskPageView());
                    Navigator.push(context, route);
                  },
                  color: Color(0xFF5036D5),
                  elevation: 5,
                  splashColor: Colors.white,
                  shape: StadiumBorder(),
                  child: Icon(Icons.add, size: 32, color: Colors.white,),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
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
              )
            ),


            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45, right: 12, left: 12),
                  child: Column(
                    children: <Widget>[
                      Text('On Board', 
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: .6,
                          fontSize: 45,
                          fontFamily: 'RobotoMono'
                        )
                      ),
                      SizedBox(height: 12),
                      Text("Here are going to be the tasks that you need to complete in order to get rewarded",
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 20,
                            fontFamily: "NotoSans"
                        ), textAlign: TextAlign.center,
                      )
                    ],
                  )
                ),
                titles.isEmpty ?
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: <Widget>[
                      SpinKitWave(
                        color: Colors.white,
                      ),
                      SizedBox(height: 12),
                      Text("Nothing To Show", style: TextStyle(
                        color: Colors.white,
                        fontFamily: "RobotoMono",
                        fontSize: 18,
                      ))
                    ],
                  ),
                )
                  : 
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: titles.length,
                      separatorBuilder: (BuildContext context, int index) => Divider(height: 18, color: Colors.transparent,),
                      itemBuilder: (BuildContext context, int index){
                        return ToDoCard(
                          title: titles[index],
                          content: contents[index],
                        );
                      },
                    )
                  ),
                )
              ],
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