import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';

class UniVioStudentRecordScreen extends StatefulWidget {
  UniVioStudentRecordScreen(this.dep, this.lev, this.sec,this.univio_students,this.date,this.date_id);
  final dep;
  final lev;
  final sec;
  final date;

  final date_id;
  final List <dynamic> univio_students;


  @override
  _UniVioStudentRecordScreenState createState() =>
      _UniVioStudentRecordScreenState(dep, lev, sec,univio_students,date,date_id);
}

class _UniVioStudentRecordScreenState extends State<UniVioStudentRecordScreen> {
  _UniVioStudentRecordScreenState(this.dep, this.lev, this.sec , this.univio_students,this.date,this.date_id);

  final dep;
  final lev;
  final sec;
  final date;
  final date_id;


  final List <dynamic> univio_students ;

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
                  await AddNewUniVioStudentRecord(date_id, univio_students);
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
            ' الالتزام بالزي المدرسي',
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
                                univio_students.indexOf(snap[index]['student_id']) == -1?
                                univio_students.add(snap[index]['student_id']) : univio_students.remove(snap[index]['student_id']);
                              });

                            },
                            title: Text(
                              snap[index]['student_name'],
                              style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold,
                                color: univio_students.indexOf(snap[index]['student_id']) == -1 ?Colors.grey[700]: Colors.red,
                              ),
                            ),

                            trailing:  univio_students.indexOf(snap[index]['student_id']) == -1 ?Icon( Icons.check ,color: Colors.grey[700], size: 30,):Icon( Icons.close , size: 30,color: Colors.red,) ,

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
