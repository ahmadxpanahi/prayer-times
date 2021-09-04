import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times_flutter/src/ui/colors.dart';
import 'package:prayer_times_flutter/src/utils/extensions.dart';
import 'package:prayer_times_flutter/src/utils/size_config.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  Widget _dateItem(title, subtitle, number, index) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 3.0.rw,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      number,
                      style: TextStyle(fontSize: SizeConfig.heightMultiplier! < 6 ? 10.0.rw : 11.0.rw),
                    ),
                    Text(
                      index,
                      style: TextStyle(
                          fontSize: 4.0.rw,
                          color: PColors.primary!.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 3.0.rw,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 5.0.rw),
                    ),
                    SizedBox(
                      height: 1.0.rw,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 4.0.rw, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              )
            ],
          ),
          Divider()
        ],
      );

  Widget _tabs() => TabBar(
          controller: _tabController,
          labelStyle: TextStyle(
                fontSize: 3.7.rw, fontWeight: FontWeight.bold),
          labelColor: PColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: PColors.primary,
          tabs: [
            Tab(
              text: '1442',
            ),
            Tab(
              text: '1443',
            ),
            Tab(
              text: '1444',
            ),
          ]);

  Widget _tabBody() => Container(
                margin: EdgeInsets.symmetric(horizontal: 3.3.rw),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.0.rw,
                      ),
                      Text(
                        'Recep',
                        style: TextStyle(
                            fontSize: SizeConfig.heightMultiplier! < 6 ? 5.8.rw : 6.5.rw , fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      _dateItem(
                          'Uc Aylarin Baslang', '13 Subat 2021', '1', 'Cts'),
                      _dateItem('Regaib kandili', '13 Subat 2021', '6', 'Pef'),
                      _dateItem('mirac kandili', '13 Subat 2021', '24', 'Car'),
                      Text(
                        'Saban',
                        style: TextStyle(
                            fontSize: SizeConfig.heightMultiplier! < 6 ? 5.8.rw : 6.5.rw, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.0.rw),
                            child: Text(
                              '12 Saban 1442',
                              style: TextStyle(
                                  fontSize: 3.0.rw,
                                  color: PColors.primary!.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                      _dateItem('mirac kandili', '13 Subat 2021', '24', 'Car'),
                      Text(
                        'Ramazan',
                        style: TextStyle(
                            fontSize: SizeConfig.heightMultiplier! < 6 ? 5.8.rw : 6.5.rw, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                    ],
                  ),
                ));

  Widget _tabsView() => Expanded(
        child: TabBarView(
          controller: _tabController!,
          children: [
            _tabBody(),
            _tabBody(),
            _tabBody()
          ],
          dragStartBehavior: DragStartBehavior.start,
        ),
      );


  Widget _buildBody() => Container(
      color: PColors.background,
      child: Container(
          color: Colors.white,
          child: Column(
            children: [_tabs(), _tabsView()],
          )),
    );

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
