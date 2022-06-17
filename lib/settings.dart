import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_timer/widgets.dart';

class SettingsScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtLong = TextEditingController();

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late int workTime;
  late int shortBreak;
  late int longBreak;

  late SharedPreferences preferences;


  @override
  void initState() {
    // TODO: implement initState
    readSettings();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
        Text("Work", style: textStyle),
        Text(""),
        Text(""),
        SettingButton(Color(0xff455A64), "-",  -1, WORKTIME, updateSetting),
        TextField(
        style: textStyle,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number),
        SettingButton(Color(0xff009688), '+',  1, WORKTIME, updateSetting),
        Text("Short", style: textStyle),
        Text(""),
        Text(""),
        SettingButton(Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
        TextField(
        style: textStyle,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number),
        SettingButton(Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
        Text("Long", style: textStyle,),
        Text(""),
        Text(""),
        SettingButton(Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
        TextField(
        style: textStyle,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number), 
        SettingButton(Color(0xff009688), "+", 1, LONGBREAK, updateSetting) 
        ],
        padding: EdgeInsets.all(20.0),
      ),      
    );
  }

  readSettings() async {
    preferences = await SharedPreferences.getInstance();
    int? workTime = preferences.getInt(WORKTIME);
    if (workTime==null) {
      await preferences.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = preferences.getInt(SHORTBREAK);
    if (shortBreak==null) {
      await preferences.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = preferences.getInt(LONGBREAK);
    if (longBreak==null) {
      await preferences.setInt(LONGBREAK, int.parse('20'));
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = preferences.getInt(WORKTIME);
          workTime = (workTime! + value);
          if (workTime >= 1 && workTime <= 180) {
            preferences.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = preferences.getInt(SHORTBREAK);
          short = (short! + value);
          if (short >= 1 && short <= 120) {
            preferences.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = preferences.getInt(LONGBREAK);
          long = (long! + value);
          if (long >= 1 && long <= 180) {
            preferences.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}