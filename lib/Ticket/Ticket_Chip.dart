import 'package:flutter/material.dart';
import 'package:iusefully/Ticket/Ticket_Page.dart';

class TicketChip extends StatefulWidget {
  final String title;
  TicketChip({this.title});

  @override
  _TicketChipState createState() => _TicketChipState();
}



class _TicketChipState extends State<TicketChip> {
  bool isClicked = true;
  int index = 0;
  
  int prevLength = chipTitles.length;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isClicked) {
          isClicked = false;
        } else {
          isClicked = true;
        }
        for (int i = 0; i < chipTitles.length; i++) {
          if (widget.title == chipTitles[i]) {
            index = i;
          }
        }

        setState(() {
          if (isClicked &&
              !chipTitles.contains(widget.title) &&
              chipTitles.length < prevLength) {
            chipTitles.add(widget.title);
          } else {
            if (chipTitles.length == 1) {
              isClicked = true;
            } else {
              chipTitles.removeAt(index);
              isClicked = false;
            }
          }
        });
        print(chipTitles);
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(widget.title,
                style: TextStyle(
                    fontFamily: "RobotoMono",
                    decoration: isClicked ? null : TextDecoration.lineThrough,
                    decorationThickness: 2.0,
                    fontWeight: FontWeight.bold,
                    color: isClicked ? Colors.black : Colors.red,
                    fontSize: 18))),
      ),
    );
  }
}
