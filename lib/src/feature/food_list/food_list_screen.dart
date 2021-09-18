import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/barcode_screen.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_event.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_state.dart';
import 'package:prayer_times_flutter/src/feature/food_list/widget/food_item.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';

class FoodListScreen extends StatelessWidget {
  Function(List<Food>)? getFoods;
  FoodListScreen({Key? key, this.getFoods}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BarcodeBloc>(
      create: (context) => BarcodeBloc(),
      child: FoodListContainer(),
    );
  }
}

class FoodListContainer extends StatefulWidget {
  const FoodListContainer({Key? key}) : super(key: key);

  @override
  _FoodListContainerState createState() => _FoodListContainerState();
}

class _FoodListContainerState extends State<FoodListContainer> {
  late BarcodeBloc _barcodeBloc;
  List<Food>? foodList;

  @override
  void initState() {
    super.initState();
    _barcodeBloc = BlocProvider.of<BarcodeBloc>(context);
    _barcodeBloc.add(GetBarcodeData());
  }

  Widget _buildBody() => Stack(
        children: [
          Container(
            child: ListView.builder(
              itemBuilder: (_, index) => FoodItem(
                food: foodList?[index],
              ),
              itemCount: foodList?.length,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BarcodeScreen(foodList??[])));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 5.0.rw),
                width: 15.0.rw,
                height: 15.0.rw,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PColors.primary,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.5,
                          offset: Offset(1.2, 5.1),
                          spreadRadius: 0.6)
                    ]),
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 8.0.rw,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeBloc, BarcodeState>(
      bloc: _barcodeBloc,
      builder: (_, state) {
        if (state is BarcodeLoadingState) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is GetBarcodeDataSuccess) {
          foodList = state.foods;
          return _buildBody();
        } else if(state is BarcodeErrorState){
          return Center(child: Text(state.error??''),);
        } else{
          return SizedBox();
        }
      },
    );
  }
}
