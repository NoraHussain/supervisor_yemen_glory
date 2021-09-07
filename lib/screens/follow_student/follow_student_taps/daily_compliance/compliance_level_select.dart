import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/follow_student/follow_student_taps/daily_compliance/add/student_absence.dart';
import 'package:supervisor_yemen_glory/screens/follow_student/follow_student_taps/daily_compliance/add/student_uniform.dart';
import 'add/student_lateness.dart';

class ComplianceLevelSelect extends StatefulWidget {
  final date;
  final date_id;
  final dep_id;

  ComplianceLevelSelect(
      {required this.date, required this.dep_id, required this.date_id});
  @override
  _ComplianceLevelSelectState createState() =>
      _ComplianceLevelSelectState(date: date, dep_id: dep_id, date_id: date_id);
}

class _ComplianceLevelSelectState extends State<ComplianceLevelSelect> {
  _ComplianceLevelSelectState(
      {required this.date, required this.dep_id, required this.date_id});

  final date;
  final dep_id;
  final date_id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            date.toString(),
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: kPrimaryColor),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'سجل الالتزام اليومي',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    'اختر الصف',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFC76BA7),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FutureBuilder(
                    future: SelectDepLevAndSec(dep_id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var snap = snapshot.data;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      else if(!snapshot.hasData){
                        return Text('no data');
                      }


                      else {
                        return Container(
                          height: MediaQuery.of(context).size.height * 2.95 / 4,
                          child: ListView.builder(
                              itemCount: snap.length,
                              itemBuilder: (_, index) {
                                return Card(
                                  margin: EdgeInsets.all(10),
                                  shape: Border(
                                      right: BorderSide(
                                          color: kPrimaryColor, width: 5)),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      leading: Image.asset(
                                        'images/numbers/${snap[index]['lev_id']}.png',
                                        width: 25,
                                      ),
                                      title: Text(
                                        getLevelString(snap[index]['lev_id']) +
                                            ' ( ${snap[index]['section_letter']} )',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700]),
                                      ),
                                      children: [
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: ListTile(
                                                onTap: () async {

                                                  List<dynamic> students = [];

                                                  students =
                                                      await SelectAbsentStudent(
                                                          date_id);

                                                  List<String> s = [];

                                                  for (var student
                                                      in students) {
                                                    s.add(student['stu_id']
                                                        .toString());
                                                    print(s);
                                                  }

                                                  await Navigator.of(context)
                                                      .push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            AbsentStudentRecordScreen(
                                                                dep_id,
                                                                snap[index]
                                                                    ['lev_id'],
                                                                snap[index][
                                                                    'section_letter'],
                                                                s,
                                                                date,
                                                                date_id)),
                                                  );
                                                },
                                                leading: Image.asset(
                                                  'images/icons/absent.png',
                                                  width: 25,
                                                ),
                                                title: Text(
                                                  ' الغياب ',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: ListTile(
                                                onTap: () async {
                                                  List<dynamic> students = [];

                                                  students =
                                                      await SelectLateStudent(
                                                          date_id);

                                                  List<String> s = [];

                                                  for (var student
                                                      in students) {
                                                    s.add(student['stu_id']
                                                        .toString());
                                                    print(s);
                                                  }

                                                  await Navigator.of(context)
                                                      .push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            LateStudentRecordScreen(
                                                                dep_id,
                                                                snap[index]
                                                                    ['lev_id'],
                                                                snap[index][
                                                                    'section_letter'],
                                                                s,
                                                                date,
                                                                date_id)),
                                                  );
                                                },
                                                leading: Image.asset(
                                                  'images/icons/lateness.png',
                                                  width: 25,
                                                ),
                                                title: Text(
                                                  ' التأخير ',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: ListTile(
                                                onTap: () async {
                                                  List<dynamic> students = [];

                                                  students = await SelectUniVioStudent(date_id);

                                                  List<String> s = [];

                                                  for (var student
                                                      in students) {
                                                    s.add(student['stu_id']
                                                        .toString());
                                                    print(s);
                                                  }
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            UniVioStudentRecordScreen(
                                                                dep_id,
                                                                snap[index]
                                                                    ['lev_id'],
                                                                snap[index][
                                                                    'section_letter'],
                                                                s,
                                                                date,
                                                                date_id)),
                                                  );
                                                },
                                                leading: Image.asset(
                                                  'images/icons/uniform.png',
                                                  width: 25,
                                                ),
                                                title: Text(
                                                  ' عدم الالتزام بالزي المدرسي',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidgetStyle extends StatelessWidget {
  CardWidgetStyle(
      {required this.num, required this.label, required this.onPress});

  final String num;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFC76BA7),
            child: Text(
              num,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
