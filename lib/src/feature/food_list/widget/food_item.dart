import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';
class FoodItem extends StatelessWidget {
  Food? food;
  FoodItem({ Key? key ,this.food}) : super(key: key);

  String status(){
    if(food != null)
    return food!.kind! ? 'Halal' : 'Haram';
    else return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.1.rh),
      child: ListTile(
        leading: Container(
          height: 15.0.rw,
          width: 15.0.rw,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://static01.nyt.com/images/2021/02/17/dining/17tootired-grilled-cheese/17tootired-grilled-cheese-articleLarge.jpg?quality=75&auto=webp&disable=upscale',),fit: BoxFit.fill),
            color: Colors.greenAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2.5,
                offset: Offset(1.2,5.1),
                spreadRadius: 0.6
              )
            ]
          ),
        ),
        title: Text(food?.name??'',style: TextStyle(fontSize: 4.0.rw,color: Colors.black),),
        subtitle: Text(food?.description??'',style: TextStyle(fontSize: 3.5.rw,color: Colors.grey),),
        onTap: (){},
        trailing: Text(status(),style: TextStyle(color: Colors.greenAccent,fontSize: 3.5.rw),),
      ),
    );
  }
}
