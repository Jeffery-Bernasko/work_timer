import 'dart:async';

import 'package:flutter/material.dart';
import 'package:work_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import 'timermodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: TimerHomePage()
    );
  }

  void emptyMethod(){}
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();


  
  @override
  Widget build(BuildContext context) {
    timer.startwork();
    return  Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding),),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: 'Work',
                      //size: 2.0, 
                      onPressed: () {  }, 
                      )
                      ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: 'Sleep',
                      //size
                      onPressed: () {},
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff455A64),
                      text: 'Break',
                      onPressed: (){},
                    ),
                  ),
                  
                ],
              ),
              Expanded(
                child: CircularPercentIndicator(
                  radius: availableWidth / 2,
                  lineWidth: 10.0,
                  percent: timer.percent,
                  center: Text(timer.time, style: Theme.of(context).textTheme.headline4),
                  progressColor: Color(0xff009688),
                )
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      onPressed: (){},
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: 'Restart',
                      onPressed: (){},
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding))
                ],
              )
            ],
        );
         } )
        );
        
  }

 
}

