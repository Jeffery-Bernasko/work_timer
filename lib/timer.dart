import 'dart:async';
import 'timermodel.dart';

class CountDownTimer{
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fullTime;
  int work = 30;

  void startwork(){
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  String returnTime(Duration t){
    String minutes = t.inMinutes.toString().padLeft(2, '0');
      int numSeconds = t.inSeconds - (t.inMinutes * 60);
      String seconds = numSeconds.toString().padLeft(2, '0');
      String formattedTime = minutes + ":" + seconds;
      return formattedTime; 
  }

  //Stream being returned

  Stream stream() async*{
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
}
