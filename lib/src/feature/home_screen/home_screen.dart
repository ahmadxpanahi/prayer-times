import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Widget _itemsList() => Column(
      children: [
        _item('Imsak', '02:45', false),
        _item('Gunes', '02:45', false),
        _item('Ogle', '02:45', true),
        _item('Ikindi', '02:45', false),
        _item('Aksam', '02:45', false),
        _item('Yatsl', '02:45', false),
      ],
    );

Widget _item(title, time, selected) => Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.1.rh,horizontal: 1.3.rw),
          color:
              selected ? PColors.primary!.withOpacity(0.7) : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 4.5.rw, color: Colors.black)),
              Text(time,
                  style: TextStyle(fontSize: 4.5.rw, color: Colors.black)),
            ],
          ),
        ),
        Container(
          height: 0.3,
          color: Colors.black,
        )
      ],
    );

Widget _topContainer() => Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.5.rw),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: PColors.primary!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Yinanistan',
                  style: TextStyle(fontSize: 4.5.rw, color: Colors.black),
                ),
                Text(
                  'iskece',
                  style: TextStyle(
                      fontSize: 6.8.rw,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '2 Eylul 2009',
                  style: TextStyle(fontSize: 4.0.rw, color: Colors.black),
                ),
                Text(
                  '12 Ramazan 1430',
                  style: TextStyle(
                    fontSize: 4.0.rw,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'saat 13:11:32',
                  style: TextStyle(
                    fontSize: 4.0.rw,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget _bottomContainer() => Expanded(
    flex: 7,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 6.3.rw),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: PColors.primary!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Simdi ogle Vakti',
            style: TextStyle(
                fontSize: 6.6.rw,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 0.3,
            color: Colors.black,
          ),
          _itemsList(),
          Text(
            'Ikindiye Kalan Sure',
            style: TextStyle(
              fontSize: 4.3.rw,
              color: Colors.black,
            ),
          ),
          Text(
            '03:38:28',
            style: TextStyle(
                fontSize: 6.6.rw,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));

Widget _buildBody() => Container(
      color: PColors.background,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(3.0.rw),
          margin: EdgeInsets.symmetric(vertical: 5.5.rh),
          color: Colors.white,
          child: Column(
            children: [
              _topContainer(),
              SizedBox(
                height: 1.2.rh,
              ),
              _bottomContainer()
            ],
          ),
        ),
      ),
    );

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
