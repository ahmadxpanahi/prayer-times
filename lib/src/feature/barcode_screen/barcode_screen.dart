import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({ Key? key }) : super(key: key);

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {

  @override
  void initState() {
    super.initState();
    
  }

  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3bba9c', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    Flushbar(
      message: "www $barcodeScanRes www",
      duration: Duration(milliseconds: 2000),
    ).show(context);

    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PColors.background,
      child: Center(
        child: ElevatedButton(
          child: Text('SCAN'),
          onPressed: (){
            Future.delayed(Duration.zero,(){scanBarcodeNormal();});
          },
        ),
      ),
    );
  }
}
