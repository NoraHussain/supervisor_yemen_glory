import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'follow_student_taps/daily_compliance/daily_compliance_student_follow.dart';

class FollowStudentsScreen extends StatefulWidget {

  final dep_id;
  FollowStudentsScreen(this.dep_id);

  @override
  _FollowStudentsScreenState createState() => _FollowStudentsScreenState(dep_id);
}

class _FollowStudentsScreenState extends State<FollowStudentsScreen>
    with TickerProviderStateMixin<FollowStudentsScreen> {

  final dep_id;

  _FollowStudentsScreenState(this.dep_id);


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'متابعة يومية للطلاب' ,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),

        body: DailyComplianceTab(dep_id),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970),
              builder: (context, child) {
                //Theme.of(context)
                return Theme(
                  data: ThemeData().copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: kPrimaryColor,
                      onPrimary: Colors.white,
                      surface: kPrimaryColor,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: Container(child: child),
                );
              },
              lastDate: DateTime(2033),
            ).then((value) {
              setState(() {
                InsertSchoolDay(value!);
              });
            });
          },
          backgroundColor: Color(0xffC76BA7),
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
        )
    );


  }
}
