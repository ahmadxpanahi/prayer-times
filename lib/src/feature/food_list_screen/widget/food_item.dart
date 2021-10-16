import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/core/p_url.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:prayer_times_flutter/src/utils/food.dart';

class FoodItem extends StatelessWidget {
  Food? food;
  FoodItem({Key? key, this.food}) : super(key: key);

  String status() {
    if (food != null)
      return food!.kind! ? 'Halal' : 'Haram';
    else
      return '';
  }

  Color statusColor() {
    if (food != null)
      return food!.kind! ? Colors.green : Colors.red;
    else
      return Colors.black;
  }

  Widget tileLeading(imageUrl) {
    if (food?.image != null) {
      return Container(
        height: 15.0.rw,
        width: 15.0.rw,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    imageUrl),
                fit: BoxFit.fill),
            color: Colors.greenAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2.5,
                  offset: Offset(1.2, 5.1),
                  spreadRadius: 0.6)
            ]),
      );
    } else {
      return Container(
        height: 15.0.rw,
        width: 15.0.rw,
        decoration: BoxDecoration(
            color: Colors.greenAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2.5,
                  offset: Offset(1.2, 5.1),
                  spreadRadius: 0.6)
            ]),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    var imageUrl = food != null
        ? '${PUrl.baseUrl}${food?.image}'
        : 'https://productimages.hepsiburada.net/s/72/375/110000014077302.jpg';
    
    print("IMAGE : ${imageUrl}");

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.1.rh),
      child: ListTile(
        leading: tileLeading(imageUrl),
        title: Text(
          food?.name ?? '',
          style: TextStyle(fontSize: 4.0.rw, color: Colors.black),
        ),
        subtitle: Text(
          food?.description ?? '',
          style: TextStyle(fontSize: 3.5.rw, color: Colors.grey),
        ),
        onTap: () {},
        trailing: Text(
          status(),
          style: TextStyle(color: statusColor(), fontSize: 3.5.rw),
        ),
      ),
    );
  }
}
