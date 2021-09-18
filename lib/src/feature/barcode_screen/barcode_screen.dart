import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/widget/app_barcode_scanner.dart';
import 'package:prayer_times_flutter/src/feature/food_list/food_list_screen.dart';
import 'package:prayer_times_flutter/src/feature/main_screen/main_screen.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/ui/flushbar.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BarcodeBloc(),
      child: BarcodeContainer(),
    );
  }
}

class BarcodeContainer extends StatefulWidget {
  const BarcodeContainer({Key? key}) : super(key: key);

  @override
  _BarcodeContainerState createState() => _BarcodeContainerState();
}

class _BarcodeContainerState extends State<BarcodeContainer> {
  String _code = '';
  String tmpCode = '8468761684';
  late BarcodeBloc _barcodeBloc;
  Widget? scanner;
  @override
  void initState() {
    super.initState();
    _barcodeBloc = BlocProvider.of<BarcodeBloc>(context);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        try {
          scanner = Container();
          // AppBarcodeScannerWidget.defaultStyle(
          //   label: 'Loading camera ...',
          //   resultCallback: (String code) {

          //       setState(() {
          //         _code = code;
          //         showFlushBar(context, code);
          //       });

          //   },
          // );
        } catch (e) {
          scanner = Center(child: Text(e.toString()));
        }
      });
    });

    Future.delayed(
        Duration(
          seconds: 3,
        ), ()async {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                  title: Text('Halal'),
                  content: Text('Code: $tmpCode'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/foods');
                        },
                        child: Text('Ok'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            return PColors.primary ?? Colors.green;
                          }),
                        ))
                  ]));
    });
  }

  _buildBody() => Scaffold(
        body: Container(
          color: PColors.background,
          child: scanner,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
