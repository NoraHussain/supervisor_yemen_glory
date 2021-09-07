import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/screens/Schedule/schedule_tabs/level_schedule.dart';
import 'package:supervisor_yemen_glory/screens/Schedule/schedule_tabs/teachers_schedule.dart';

import '../../constraints.dart';

class ScheduleScreen extends StatefulWidget {

  final dep;
  ScheduleScreen(this.dep);


  @override
  _ScheduleScreenState createState() => _ScheduleScreenState(dep);
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin<ScheduleScreen> {

  final dep;
  _ScheduleScreenState(this.dep);

  late TabController atabController;

  @override
  void initState() {
    atabController = TabController(length:2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: TabBar(
          tabs: [
            Tab(
              text: 'جدول المدرسين ',
            ),
            Tab(
              text: 'جدول الصفوف ',
            ),
          ],
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Creates border
              color: kPrimaryColor),
          labelStyle: TextStyle(fontFamily: kPrimaryFont),
          unselectedLabelStyle: TextStyle(fontFamily: kPrimaryFont),
          labelColor: Colors.white,
          unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
          isScrollable: true,
          controller: atabController,
        ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            'الجدول  ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20, top: 10),
        ),
        tabBar,
        Container(
          height: MediaQuery.of(context).size.height * 2 / 3 - 40,
          child: TabBarView(
            controller: atabController,
            physics: NeverScrollableScrollPhysics(),
            children: [TeachersScheduleTab(dep.toString()), LevelsScheduleTab(dep.toString()), ],
          ),
        )
      ],
    );
  }
}
