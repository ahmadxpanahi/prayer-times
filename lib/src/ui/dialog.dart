import 'package:flutter/material.dart';
import 'colors.dart';

void pShowDialog(context, _currentFood, content) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
              title: Text(_currentFood[0].kind! ? 'Halal' : 'Haram'),
              content: Text(content),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/foods');
                    },
                    child: Text('Ok'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return PColors.primary ?? Colors.green;
                      }),
                    ))
              ]));
}
