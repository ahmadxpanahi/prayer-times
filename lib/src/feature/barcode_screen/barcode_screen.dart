import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/widget/app_barcode_scanner.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/ui/flushbar.dart';

class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  String _code = '';

  @override
  void initState() {
    super.initState();

    print("barcode_screen");
  }

  @override
  Widget build(BuildContext context) {
    Widget scanner = Text("DEFAULT");
    try {
      scanner = AppBarcodeScannerWidget.defaultStyle(
        label: 'Loading camera ...',
        resultCallback: (String code) {
          Future.delayed(Duration.zero, () {
            setState(() {
              _code = code;
              print(code);
              showFlushBar(context, code);
            });
          });
        },
      );
    } catch (e) {
      scanner = Text(e.toString());
    }

    return Container(
      color: PColors.background,
      child: scanner,
    );
  }
}
