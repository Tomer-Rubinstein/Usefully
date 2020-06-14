import 'package:flutter/material.dart';


class NewTaskPageModel extends StatefulWidget {
  final String title;
  final String content;
  final TextEditingController controller; // final = bug?
  final String imageLocation;
  final bool isTitle;

  NewTaskPageModel({this.title, this.content, this.controller, this.imageLocation, this.isTitle: false});

  @override
  _NewTaskPageModelState createState() => _NewTaskPageModelState();
}

class _NewTaskPageModelState extends State<NewTaskPageModel> {
  LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.4, 0.7, 0.9],
    colors: [
      Color(0xFF3594DD),
      Color(0xFF4563DB),
      Color(0xFF5036D5),
      Color(0xFF5B16D0),
    ],
  );


  TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: "RobotoMono",
    fontSize: 34,
    letterSpacing: .6
  );

  TextStyle contentStyle = TextStyle(
    color: Colors.white,
    fontFamily: "RobotoMono",
    fontSize: 18
  );



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70, right: 16, left: 50),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                SizedBox(height: 10),
                Image.asset(widget.imageLocation, width: 300, height: 300),
                SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.title, style: titleStyle),
                      SizedBox(height: 6),
                      Text(widget.content, style: contentStyle),
                      SizedBox(height: 38),
                      Container(
                        width: 250,
                        height: 80,
                        child: TextField(
                          style: contentStyle,
                          //textInputAction: (currentIndex == pageModels.length-1) ? TextInputAction.done : TextInputAction.next,
                          controller: widget.controller,
                          autocorrect: true,
                          // onSubmitted: (text){
                          //   setState(() {
                          //     if(currentIndex >= pageModels.length-1){
                          //       pageController.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                          //       currentIndex = 0;
                          //         if(taskContentController.text.isEmpty || taskTitleController.text.isEmpty || taskRewardController.text.isEmpty){
                          //           showModal(
                          //             configuration: FadeScaleTransitionConfiguration(),
                          //             context: context,
                          //             builder: (context){
                          //               return CustomAlertDialog(
                          //                 title: Row(
                          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                   children: <Widget>[
                          //                     Container(width: 30),
                          //                     Text("Error", style: TextStyle(fontSize: 22)),
                          //                     IconButton(
                          //                       icon: Icon(Icons.close),
                          //                       onPressed: (){
                          //                         Navigator.of(context).pop();
                          //                       },
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 content: Column(
                          //                   mainAxisAlignment: MainAxisAlignment.start,
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: <Widget>[
                          //                     Text("Please enter valid information, ", textAlign: TextAlign.center),
                          //                     Text("make sure you have filled all text fields.", textAlign: TextAlign.center),
                          //                   ],
                          //                 )
                          //               );
                          //             }
                          //           );
                          //         }else{
                          //           titles.add(taskTitleController.text.toString());
                          //           contents.add(taskContentController.text.toString());
                          //           rewards.add(taskRewardController.text.toString());
                          //           authService.createNewTask(user);
                          //           taskContentController.text = "";
                          //           taskTitleController.text = "";
                          //           taskRewardController.text = "";
                          //           pageController.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                          //           currentIndex = 0;
                          //           Navigator.of(context).pop();
                          //         }
                          //     }
                          //     currentIndex++;
                          //     pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                          //   });
                          // },
                          maxLength: widget.isTitle ? 20 : 50,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            
                            counterStyle: TextStyle(color: Colors.white),
                            labelText: widget.title,
                            labelStyle: contentStyle,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
