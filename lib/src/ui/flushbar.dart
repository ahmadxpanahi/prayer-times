import 'package:another_flushbar/flushbar.dart';

showFlushBar(context,message, {seconds: 2}){
  Flushbar(
    message: message,
    duration: Duration(seconds: seconds),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}