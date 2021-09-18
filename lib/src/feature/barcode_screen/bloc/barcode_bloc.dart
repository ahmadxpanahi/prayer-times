import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_event.dart';
import 'package:prayer_times_flutter/src/feature/barcode_screen/bloc/barcode_state.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';

class BarcodeBloc extends Bloc<BarcodeEvent,BarcodeState> {
  BarcodeBloc() : super(BarcodeInitialState());

  @override
  Stream<BarcodeState> mapEventToState(BarcodeEvent event) async*{
    if(event is GetBarcodeData){
      yield* _getBarcodeData();
    }else if(event is ShowBarcodeLoading){
      yield BarcodeLoadingState();
    }else if(event is ShowBarcodeError){
      yield BarcodeErrorState();
    }
    
  }

  Stream<BarcodeState> _getBarcodeData() async*{

    yield BarcodeLoadingState();

    try{
      var url = Uri.parse('http://192.168.1.11:3000/foods');
      var response = await http.get(url);
      List foods = json.decode(response.body)['data'];
      List<Food> foodList = foods.map((e) => 
        Food.fromJson(e)
      ).toList();
      
      yield GetBarcodeDataSuccess(foodList);
    }on SocketException catch(e){
      yield BarcodeErrorState(error: 'Check your internet connection!');
    }on Exception catch(e){
      print(e);
    }

  }

}
