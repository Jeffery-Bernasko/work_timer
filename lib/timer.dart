import 'dart:async';
import 'timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer{
  double _radius = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration _fullTime;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 5;

  // function to start the timer
  void startwork() async {
    await readSetting();
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  //function to stop the timer
  void stopTimer(){
    this._isActive = false;
  }

  void startTimer(){
    if(_time.inSeconds > 0){
      this._isActive = true;
    }
  }

  //Method to Start Break
  void startBreak(bool isShort){
    _radius =1;
    _time = Duration(
      minutes: (isShort) ? shortBreak : longBreak,
      seconds: 0
      );
    _fullTime = _time;
  }



  String returnTime(Duration t){
    String minutes = (t.inMinutes < 10 ) ? '0' + t.inMinutes.toString() : 
      t.inMinutes.toString();
      int numSeconds = t.inSeconds - (t.inMinutes * 60);
      String seconds = (numSeconds < 10 ) ? '0' + numSeconds.toString() :
      numSeconds.toString();
      String formattedTime = minutes + ":" + seconds;
      return formattedTime; 
  }

  //Stream being returned

  Stream stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a){
      String time;
      if(this._isActive){
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if(_time.inSeconds <= 0){
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  Future readSetting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    work = (preferences.getInt('WorkTime') == null ? 30 : preferences.getInt('WorkTime'))!;
    shortBreak = (preferences.getInt('shortBreak') == null ? 30 : preferences.getInt('shortBreak'))!;
    longBreak = (preferences.getInt('longBreak') == null ? 30 : preferences.getInt('longBreak'))!;
  }
}