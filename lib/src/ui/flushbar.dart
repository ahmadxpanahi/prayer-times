import 'package:another_flushbar/flushbar.dart';

showFlushBar(context,message){
  Flushbar(
    message: message,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}