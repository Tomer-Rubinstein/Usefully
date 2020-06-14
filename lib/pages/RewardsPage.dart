import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';
import 'package:provider/provider.dart';

class RewardsPage extends StatefulWidget{
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  int _index = 0;

  int _length = 0;

  bool randomReward = false;

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
              }
            }
          }
            
          // Getting the length of the users collection.
          Firestore.instance.collection('users').getDocuments().then((theDocuments) {
            _length = theDocuments.documents.length;
          }).whenComplete(() {
            findUser(_length);
          });

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
              )
            ),


            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45, right: 12, left: 12),
                  child: Column(
                    children: <Widget>[
                      Text('Rewards', 
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: .6,
                          fontSize: 45,
                          fontFamily: 'RobotoMono'
                        )
                      ),
                      SizedBox(height: 12),
                      Text("Whenever you complete a task, you can do one of your rewards\n",
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
                  padding: const EdgeInsets.only(top: 110),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.white,
                      size: 60,
                    ),
                  )
                )
                  : 
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: List<String>.from(snapshot.data.documents[_index]["rewards"]).length,
                        separatorBuilder: (BuildContext context, int index) => Divider(height: 18, color: Colors.transparent,),
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                            width: double.infinity,
                            height: 110,
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
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(snapshot.data.documents[_index]["rewards"][index].toString(), style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "NotoSans",
                                  fontSize: 24,
                                ), textAlign: TextAlign.center),
                              ),
                            ),
                          );
                        },
                      ),
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