import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/widget/app_barcode_scanner.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/ui/dialog.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';

class BarcodeScreen extends StatelessWidget {
  List<Food> foodList;
  BarcodeScreen(this.foodList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BarcodeBloc(),
      child: BarcodeContainer(foodList),
    );
  }
}

class BarcodeContainer extends StatefulWidget {
  List<Food> foodList;
  BarcodeContainer(this.foodList, {Key? key}) : super(key: key);

  @override
  _BarcodeContainerState createState() => _BarcodeContainerState();
}
class _BarcodeContainerState extends State<BarcodeContainer> {
  String _code = '';
  late BarcodeBloc _barcodeBloc;
  Widget? scanner;

  @override
  void initState() {
    super.initState();
    _barcodeBloc = BlocProvider.of<BarcodeBloc>(context);

    setState(() {
      try {
        scanner = AppBarcodeScannerWidget.defaultStyle(
          label: 'Loading camera ...',
          resultCallback: (String code) {
            setState(() {
              _code = code;
              List<Food>? _currentFood = widget.foodList
                  .where((food) => food.barcode!.contains(_code))
                  .toList();
              if (_currentFood.length > 0) {
                pShowDialog(context, _currentFood, 'Code: $_code');
              } else {
                pShowDialog(context, _currentFood, 'Barcode is not registered!');
              }
            });
          },
        );
      } catch (e) {
        scanner = Center(child: Text(e.toString()));
      }
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
