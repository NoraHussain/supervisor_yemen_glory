import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';

class AbsentStudentRecordScreen extends StatefulWidget {
  AbsentStudentRecordScreen(this.dep, this.lev, this.sec,this.absent_students,this.date,this.date_id);
  final dep;
  final lev;
  final sec;
  final date;

  final date_id;
  final List <dynamic> absent_students;


  @override
  _AbsentStudentRecordScreenState createState() =>
      _AbsentStudentRecordScreenState(dep, lev, sec,absent_students,date,date_id);
}

class _AbsentStudentRecordScreenState extends State<AbsentStudentRecordScreen> {
  _AbsentStudentRecordScreenState(this.dep, this.lev, this.sec , this.absent_students,this.date,this.date_id);

  final dep;
  final lev;
  final sec;
  final date;
  final date_id;


  final List <dynamic> absent_students ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () async{
                 // print (absent_students);
                  await AddNewAbsentStudentRecord(date_id, absent_students);
                  Navigator.pop(context);

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
            'الحضور والغياب',
            style: TextStyle(color: kPrimaryColor, fontSize: 17),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  getLevelString(lev) + '( $sec )  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 18),
                ),
              ),
              
              Flexible(
                child: FutureBuilder(
                  future: SelectDepLevSevStudents(dep, lev, sec),
                  builder:
                      (BuildContext context, AsyncSnapshot snapshot) {

                    var snap = snapshot.data;


                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        itemCount: snap.length,
                        itemBuilder: (_, index) => Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            onTap: (){
                              setState(() {
                                absent_students.indexOf(snap[index]['student_id']) == -1?
                                absent_students.add(snap[index]['student_id']) : absent_students.remove(snap[index]['student_id']);
                              });

                             },
                            title: Text(
                               snap[index]['student_name'],
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold,
                              color: absent_students.indexOf(snap[index]['student_id']) == -1 ?Colors.grey[700]: Colors.red,
                              ),
                            ),

                            trailing:  absent_students.indexOf(snap[index]['student_id']) == -1 ?Icon( Icons.check ,color: Colors.grey[700], size: 30,):Icon( Icons.close , size: 30,color: Colors.red,) ,

                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
