import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget{
  final String title;
  final String content;
  CustomDialog({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 250,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: <Widget>[
              SizedBox(height: 22),
              Text(title, style: TextStyle(
                fontSize: 36,
                fontFamily: "NotoSans",
                fontWeight: FontWeight.bold,
                letterSpacing: .6
              )),
              SizedBox(height: 12),
              Text(content, style: TextStyle(
                fontFamily: "NotoSans",
                fontSize: 17
              ), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
