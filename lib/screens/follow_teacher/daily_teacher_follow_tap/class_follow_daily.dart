import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/models/get_class_order_string.dart';
import 'package:supervisor_yemen_glory/models/get_day.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/models/get_subject_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';

import '../../../../constraints.dart';

class ClassFollowDaily extends StatefulWidget {
  final date;
  final date_id;
  final day;
  final dep;
  final teacher_id;
  final teacher_name;
  final  a_classes;
  final  np_classes;
  final  na_classes;

  ClassFollowDaily(
      {
        required this.date,
        required this.date_id,
      required this.day,
      required this.dep,
      required this.teacher_id,
      required this.teacher_name,
      required this.a_classes,
        required this.np_classes,
        required this.na_classes
      });

  @override
  _ClassFollowDailyState createState() => _ClassFollowDailyState(
      day: day,
      date: date,
      date_id: date_id,
      dep: dep,
      teacher_id: teacher_id,
      teacher_name: teacher_name,
    a_classes: a_classes,
    na_classes: na_classes,
    np_classes: np_classes
  );
}

class _ClassFollowDailyState extends State<ClassFollowDaily> {
  final date;
  final date_id;
  final day;
  final dep;
  final teacher_id;
  final teacher_name;
  final List<dynamic>  a_classes;
  final  np_classes;
  final  na_classes;

  _ClassFollowDailyState(
      {
      required this.date,
        required this.date_id,
      required this.day,
      required this.dep,
      required this.teacher_id,
      required this.teacher_name ,
      required this.a_classes,
        required this.np_classes,
        required this.na_classes
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () async{
               await AddNewAbsentTeacherClassesRecord(classes: a_classes , date_id: date_id, teacher: teacher_id );
               await AddNewNoPrepTeacherClassesRecord(classes: np_classes , date_id: date_id, teacher: teacher_id );
               await AddNewNoAidTeacherClassesRecord(classes: na_classes , date_id: date_id, teacher: teacher_id );


                Navigator.pop(context);

                print(a_classes);
              },
              child: Text(
                'حفظ',
                style: TextStyle(color: kPrimaryColor),
              )),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'إلغاء',
              style: TextStyle(color: kPrimaryColor),
            ),
          )
        ],
        title: Text(
          ' ${getDay(day) }: $date',
          style: TextStyle(color: kPrimaryColor, fontSize: 17),
        ),
      ),
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            teacher_name,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: FutureBuilder(
          future: SelectDepTeacherDayClasses(dep, teacher_id, day),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            else if(!snapshot.hasData){
              return Text('no data');
            }
            else {

              var snap = snapshot.data;

              return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (_, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      shape: Border(
                          right: BorderSide(color: kPrimaryColor, width: 5)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getClassOrderStrong(snap[index]['schedule_order']) + '  -  '+ getSubjectName(snap[index]['sub_id']) + '  -  '+ getLevelString(snap[index]['lev_id']) + ' ( '+ snap[index]['sec_letter']+ ' ) ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                              fontSize: 17),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                ListTile(
                                  onTap: (){

                                    setState(() {
                                      a_classes.indexOf(snap[index]['schedule_id']) == -1?
                                      a_classes.add(snap[index]['schedule_id']) : a_classes.remove(snap[index]['schedule_id']);

                                      print(a_classes);
                                    });
                                  },
                                  leading: Image.asset(
                                    'images/icons/absent.png',
                                    width: 20,
                                  ),
                                  title: Text('حضور' ),
                                  trailing: a_classes.indexOf(snap[index]['schedule_id']) == -1  ? Icon(Icons.check ,  size: 25, color: Colors.green) : Icon(Icons.close , size: 25, color: Colors.red,) ,
                                ),
                                Divider(
                                  indent: 40,
                                ),
                                ListTile(
                                  onTap: (){

                                    setState(() {
                                      np_classes.indexOf(snap[index]['schedule_id']) == -1?
                                      np_classes.add(snap[index]['schedule_id']) : np_classes.remove(snap[index]['schedule_id']);

                                      print(np_classes);
                                    });
                                  },
                                  leading: Image.asset(
                                    'images/icons/book.png',
                                    width: 20,
                                  ),
                                  title: Text('دفتر التحضير'),
                                  trailing: np_classes.indexOf(snap[index]['schedule_id']) == -1  ? Icon(Icons.check ,  size: 25, color: Colors.green) : Icon(Icons.close , size: 25, color: Colors.red,) ,
                                ),
                                Divider(
                                  indent: 40,
                                ),
                                ListTile(
                                  onTap: (){

                                    setState(() {
                                      na_classes.indexOf(snap[index]['schedule_id']) == -1?
                                      na_classes.add(snap[index]['schedule_id']) : na_classes.remove(snap[index]['schedule_id']);

                                      print(na_classes);
                                    });
                                  },
                                  leading: Image.asset(
                                    'images/icons/idea.png',
                                    width: 20,
                                  ),
                                  title: Text('الوسائل'),
                                  trailing: na_classes.indexOf(snap[index]['schedule_id']) == -1  ? Icon(Icons.check ,  size: 25, color: Colors.green) : Icon(Icons.close , size: 25, color: Colors.red,) ,

                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}