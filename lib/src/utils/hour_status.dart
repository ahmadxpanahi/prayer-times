import 'package:prayer_times_flutter/src/utils/extensions.dart';

hourStatus(imsak,gunes,ogle,ikindi,aksam,yatsi){

  var hour = DateTime.now().hour;
  var min = DateTime.now().minute;
  DateTime now = DateTime.now();
  String nowString = '${now.year}-${now.month.timePadded}-${now.day.timePadded}';
  DateTime _imsak = DateTime.parse('$nowString $imsak:00');
  DateTime _gunes = DateTime.parse('$nowString $gunes:00');
  DateTime _ogle = DateTime.parse('$nowString $ogle:00');
  DateTime _ikindi = DateTime.parse('$nowString $ikindi:00');
  DateTime _aksam = DateTime.parse('$nowString $aksam:00');
  DateTime _yatsi = DateTime.parse('$nowString $yatsi:00');

  if(hour < _imsak.hour){
    return 0;
  }else if(hour < _gunes.hour && hour > _imsak.hour){
    return 1;
  }else if(hour < _ogle.hour && hour > _gunes.hour){
    return 2;
  }else if(hour < _ikindi.hour && hour > _ogle.hour){
    return 3;
  }else if(hour < _aksam.hour && hour > _ikindi.hour){
    return 4;
  }else if(hour < _yatsi.hour && hour > _aksam.hour){
    return 5;
  }else if(hour == _imsak.hour && min < _imsak.minute){
    return 0;
  }else if(hour == _imsak.hour && min > _imsak.minute){
    return 1;
  }else if(hour == _gunes.hour && min < _gunes.minute){
    return 1;
  }else if(hour == _gunes.hour && min > _gunes.minute){
    return 2;
  }else if(hour == _ogle.hour && min < _ogle.minute){
    return 2;
  }else if(hour == _ogle.hour && min > _ogle.minute){
    return 3;
  }else if(hour == _ikindi.hour && min < _ikindi.minute){
    return 3;
  }else if(hour == _ikindi.hour && min > _ikindi.minute){
    return 4;
  }else if(hour == _aksam.hour && min < _aksam.minute){
    return 4;
  }else if(hour == _aksam.hour && min > _aksam.minute){
    return 5;
  }else if(hour == _yatsi.hour && min < _yatsi.minute){
    return 5;
  }else if(hour == _yatsi.hour && min > _yatsi.minute){
    return 0;
  }else if(hour > _yatsi.hour){
    return 0;
  }

}

hourStatusName(value){
  switch (value){
    case 0 : return 'Morning';
    case 1 : return 'Sunrise';
    case 2 : return 'Noon';
    case 3 : return 'Afternoon';
    case 4 : return 'Evening';
    case 5 : return 'Night';
  }
}
