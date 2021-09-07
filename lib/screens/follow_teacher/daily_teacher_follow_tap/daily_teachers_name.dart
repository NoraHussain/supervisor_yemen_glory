import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/follow_teacher/daily_teacher_follow_tap/class_follow_daily.dart';

class DailyTeacherNameScreen extends StatefulWidget {
  DailyTeacherNameScreen(
      {required this.dep_id, required this.date, required this.day,required this.date_id});
  final dep_id;
  final day;
  final date;
  final date_id;

  @override
  _DailyTeacherNameScreenState createState() =>
      _DailyTeacherNameScreenState(date: date, dep_id: dep_id, day: day , date_id: date_id);
}

class _DailyTeacherNameScreenState extends State<DailyTeacherNameScreen> {
  _DailyTeacherNameScreenState(
      {required this.dep_id, required this.date, required this.day , required this.date_id});
  final dep_id;
  final day;
  final date;
  final date_id;

  @override
  Widget build(BuildContext context) {
    GetDay(day) {
      switch (day) {
        case 'Monday':
          return ' الاثنين ';

        case 'Thursday':
          return ' الثلاثاء ';

        case 'Wednesday':
          return ' الأربعاء  ';

        case 'Tuesday':
          return ' الخميس ';

        case 'Friday':
          return ' الجمعة  ';

        case 'Saturday':
          return ' السبت ';

        case 'Sunday':
          return ' الأحد  ';

        default:
          return 'fgh';
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: kPrimaryColor),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            GetDay(day) + '  ' + date.toString(),
            style: TextStyle(color: kPrimaryColor, fontSize: 17),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: SelectDepTeachers(dep_id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              var snap = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              else if(!snapshot.hasData){
                return Text('no data');
              }

              else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      'معلمو القسم ',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  body: ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (_, index) => Card(
                      shape: Border(
                          right: BorderSide(color: kPrimaryColor, width: 5)),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        onTap: () async {

                          List<dynamic> a_classes = [];

                          a_classes = await SelectAbsentTeacherClasses(
                              date_id, snap[index]['teacher_id']);

                          List<String> c = [];

                          for (var clas in a_classes) {
                            c.add(clas['class_id'].toString());
                            print(c);
                          }

                          List<dynamic> np_classes = [];

                          np_classes = await SelectNoPrepTeacherClasses(
                              date_id, snap[index]['teacher_id']);

                          List<String> np = [];

                          for (var clas in np_classes) {
                            np.add(clas['class_id'].toString());
                            print(np);
                          }

                          List<dynamic> na_classes = [];

                          na_classes = await SelectNoAidTeacherClasses(
                              date_id, snap[index]['teacher_id']);

                          List<String> na = [];

                          for (var clas in na_classes) {
                            na.add(clas['class_id'].toString());
                            print(na);
                          }

                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => ClassFollowDaily(
                                      date: date,
                                      date_id: date_id,
                                      day: day,
                                      dep: dep_id,
                                      teacher_id: snap[index]['teacher_id'],
                                      teacher_name: snap[index]
                                          ['teacher_fullname'],
                                  a_classes: c,
                                  na_classes:na,
                                  np_classes: np,
                                    )),
                          );
                        },
                        title: Text(
                          snap[index]['teacher_fullname'],
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
