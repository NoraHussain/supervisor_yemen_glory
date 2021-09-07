import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/Schedule/schedule_tabs/one_teacher_schedule.dart';

import '../../../constraints.dart';


class TeachersScheduleTab extends StatefulWidget {

  final dep;
  TeachersScheduleTab(this.dep);


  @override
  _TeachersScheduleTabState createState() => _TeachersScheduleTabState(dep);
}

class _TeachersScheduleTabState extends State<TeachersScheduleTab> {

  final dep;
  _TeachersScheduleTabState(this.dep);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(
        future: SelectDepTeachers(dep),

        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return CircularProgressIndicator();
            }
          else{
            var snap = snapshot.data;
            return ListView.builder(
              itemCount: snap.length,
              itemBuilder: (_, index) => Card(
                shape:
                Border(right: BorderSide(color: kPrimaryColor, width: 5)),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset('images/icons/a_teacher.png' , width: 25,),

                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => OneTeacherSchedule(
                          dep.toString() , snap[index]['teacher_id'].toString(), snap[index]['teacher_fullname'],
                        )),
                      );
                    },
                    title: Text(
                      snap[index]['teacher_fullname'],
                      
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },

      ),
    );
  }
}
