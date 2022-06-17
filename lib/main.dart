import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


import 'package:work_timer/settings.dart';
import 'package:work_timer/widgets.dart';

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

    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];

    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text("Settings")
    ));
    timer.startwork();
    return  Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context){
                return menuItems.toList();
              },
              onSelected: (s){
                if(s == 'Settings'){
                  goToSetiings(context);
                }
              },
              ),
              
          ],
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
                      onPressed: () => timer.startwork(), 
                      )
                      ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: 'Sleep',
                      //size
                      onPressed: () => timer.startBreak(true),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff455A64),
                      text: 'Break',
                      onPressed: () => timer.startBreak(false),
                    ),
                  ),
                  
                ],
              ),
              Expanded(
                child: StreamBuilder<Object>(
                  initialData: ('00:00'),
                 // stream: timer.stream(), 
                  builder: (context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00') ? TimerModel('00:00',1) : snapshot.data;
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 10.0,
                        percent: timer.percent,
                        center: Text(timer.time, style: Theme.of(context).textTheme.headline4),
                        progressColor: Color(0xff009688),
                      ),
                    );
                  }
                )
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      onPressed: () => timer.stopTimer(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: 'Restart',
                      onPressed: () => timer.startTimer(),
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

  void goToSetiings(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}

