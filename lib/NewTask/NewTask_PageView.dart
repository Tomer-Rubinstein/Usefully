import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:iusefully/Dialog.dart';
import 'package:iusefully/NewTask/NewTask_PageModel.dart';
import 'package:flutter/services.dart';
import 'package:iusefully/auth.dart';
import 'package:provider/provider.dart';

TextEditingController taskTitleController = TextEditingController();
TextEditingController taskContentController = TextEditingController();
TextEditingController taskRewardController = TextEditingController();

List<String> titles = [];
List<String> contents = [];
List<String> rewards = [];

List<String> log_rewards = [];
List<String> log_titles = [];


int currentIndex = 0;
bool isLast = false;

final pageController = PageController(initialPage: currentIndex, keepPage: false);

final List<NewTaskPageModel> pageModels = [
  NewTaskPageModel(
    title: "Title",
    content:
        "Give your task a title. The title should be short, one or two words.\n",
    controller: taskTitleController,
    imageLocation: "images/onboarding1.png",
    isTitle: true,
  ),
  NewTaskPageModel(
    title: "Content",
    content:
        "Explain your goal. The explaination should be simple, so you can read it later easily",
    controller: taskContentController,
    imageLocation: "images/onboarding2.png",
  ),
  NewTaskPageModel(
    title: "Reward",
    content:
        "When you complete the task, what will you get?\n",
    controller: taskRewardController,
    imageLocation: "images/onboarding0.png",
  ),
];

class NewTaskPageView extends StatefulWidget {
  @override
  _NewTaskPageViewState createState() => _NewTaskPageViewState();
}

class _NewTaskPageViewState extends State<NewTaskPageView> {
  
  int _index = 0;
  int _length = 0;
  
  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: isCurrentPage ? 10 : 10,
      width: isCurrentPage ? 18 : 10,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light
    ));

    setState(() {
      if(pageModels.length-1 == currentIndex){
        isLast = true;
      }else{
        isLast = false;
      }
    });

    
    return StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){ // COPY
          var user = Provider.of<FirebaseUser>(context);
          void findUser(length){
            for(int i=0; i < length; i++){
              if(user.uid == snapshot.data.documents[i]["uid"]){
                _index = i;
              }
            }
          }
          
          titles = new List<String>.from(snapshot.data.documents[_index]["titles"]);
          contents = new List<String>.from(snapshot.data.documents[_index]["contents"]);
          rewards = new List<String>.from(snapshot.data.documents[_index]["rewards"]);

          // Getting the length of the users collection.
          Firestore.instance.collection('users').getDocuments().then((theDocuments) {
            _length = theDocuments.documents.length;
          }).whenComplete(() {
            findUser(_length);
          });

          return Scaffold(
            body: Stack(
              children: <Widget>[
                PageView.builder(
                  itemCount: pageModels.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return pageModels[index];
                  },
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Container(width: 30),
                          InkWell(
                            child: Icon(Icons.close, color: Colors.white, size: 32),
                            splashColor: Colors.grey,
                            onTap: (){
                              Navigator.of(context).pop();
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (int i = 0; i < pageModels.length; i++)
                                  currentIndex == i
                                      ? pageIndexIndicator(true)
                                      : pageIndexIndicator(false)
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.grey,
                            child: isLast ? 
                            Icon(Icons.done, color: Colors.white, size: 32)
                            :
                            Icon(Icons.arrow_forward, color: Colors.white, size: 32),

                            onTap: isLast ? 
                            (){
                              setState(() {
                                if(taskContentController.text.isEmpty || taskTitleController.text.isEmpty || taskRewardController.text.isEmpty){
                                  showModal(
                                    configuration: FadeScaleTransitionConfiguration(),
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(width: 30),
                                            Text("Error", style: TextStyle(fontSize: 22)),
                                            IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text("Please enter valid information, ", textAlign: TextAlign.center),
                                            Text("make sure you have filled all text fields.", textAlign: TextAlign.center),
                                          ],
                                        )
                                      );
                                    }
                                  );
                                }else{
                                  titles.add(taskTitleController.text.toString());
                                  contents.add(taskContentController.text.toString());
                                  rewards.add(taskRewardController.text.toString());
                                  print("TEST: $titles");
                                  authService.createNewTask(user);
                                  taskContentController.text = "";
                                  taskTitleController.text = "";
                                  taskRewardController.text = "";
                                  currentIndex = 0;
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                            : 
                            () {
                              setState(() {
                                if (currentIndex >= pageModels.length)
                                  currentIndex = currentIndex;
                                else
                                  currentIndex++;
                              });
                              print(currentIndex);
                              if (currentIndex == 0) {
                                pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              }
                              if (currentIndex == 1) {
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              }
                              if (currentIndex == 2) {
                                pageController.animateToPage(2,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
          ));
        }else{
          return Container();
        }
      }
    );
  }
}
