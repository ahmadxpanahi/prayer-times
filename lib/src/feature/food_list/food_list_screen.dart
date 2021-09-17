import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_event.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_state.dart';
import 'package:prayer_times_flutter/src/feature/food_list/widget/food_item.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({Key? key}) : super(key: key);
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

  Widget _buildBody() => Container(
        child: ListView.builder(
          itemBuilder: (_, index) => FoodItem(food: foodList?[index],),
          itemCount: foodList?.length,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeBloc,BarcodeState>(
      bloc: _barcodeBloc,
      builder: (_, state) {
        if (state is BarcodeLoadingState) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is GetBarcodeDataSuccess) {
          foodList = state.foods;
          return _buildBody();
        } else {
          return SizedBox();
        }
      },
    );
  }
}
