import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/screens/follow_teacher/daily_teacher_follow_tap/daily_teacher_follow_tap.dart';

class FollowTeachersScreen extends StatefulWidget {

  final dep_id;

  FollowTeachersScreen (this.dep_id);

  @override
  _FollowTeachersScreenState createState() => _FollowTeachersScreenState(dep_id);
}

class _FollowTeachersScreenState extends State<FollowTeachersScreen>
    with TickerProviderStateMixin<FollowTeachersScreen> {

  final dep_id;

  _FollowTeachersScreenState (this.dep_id);



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'متابعة يومية للمعلمين' ,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: DailyTeacherFollowTap(
            dep_id
          ),
    );



  }
}
