import 'package:flutter/material.dart';


class DailyLogCard extends StatelessWidget {
  final String title;
  final List<String> log_titles;
  final List<String> log_rewards;
  final bool isTitles;
  final TextStyle _contentStyle = TextStyle(fontSize: 18, fontFamily: "NotoSans");
  DailyLogCard(this.title, this.log_titles, this.log_rewards, this.isTitles);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              isTitles ? 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.arrow_forward, color: Colors.transparent, size: 26),
                    Text(title,
                      style: TextStyle(
                        fontFamily: "RobotoMono",
                        fontSize: 28,
                    )),
                    Tooltip(
                      message: "Swipe Right",
                      child: Icon(Icons.arrow_forward, color: Colors.black, size: 32),
                    )
                  ],
                ),
              )
                : 
              Text(title,
                  style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontSize: 28,
                  )),
              SizedBox(height: 12),
              for (int i = 0; i < log_titles.length; i++)
                isTitles
                    ? Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                          log_titles[i],
                          style: _contentStyle,
                        ),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                          log_rewards[i],
                          style: _contentStyle,
                        ),
                    )
            ],
          ),
        ));
  }
}
