import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/models/get_class_order_string.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/models/get_subject_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';

import '../../../constraints.dart';

class OneTeacherSchedule extends StatefulWidget {

  final dep;
  final tea_id;
  final teacher;

  OneTeacherSchedule(this.dep , this.tea_id, this.teacher);


  @override
  _OneTeacherScheduleState createState() => _OneTeacherScheduleState(dep,tea_id,teacher);
}

class _OneTeacherScheduleState extends State<OneTeacherSchedule> {

  final dep;
  final tea_id;
  final teacher;

  _OneTeacherScheduleState(this.dep , this.tea_id , this.teacher);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kPrimaryColor
        ),
        title: Text(
          teacher,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16
          ),
        ),

      ),
      body:  ListView(
       children:[
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
           child: Card(
             shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
               child: Center(
                 child: Theme(
                   data: Theme.of(context)
                       .copyWith(dividerColor: Colors.transparent),
                   child: ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                     tilePadding: EdgeInsets.all(0),
                     title: Padding(
                       padding: const EdgeInsets.only(right: 10),
                       child: Text(
                         'يوم السبت ',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: kPrimaryColor,
                           fontSize: 15,
                         ),
                       ),
                     ),
                     leading: Image.asset(
                       'images/days/1.png',
                       width: 30,
                     ),
                     children: [
                       Divider(
                         color: Colors.grey,
                       ),
                       FutureBuilder(
                         future: SelectTeacherOneDaySchedule(dep: dep , teacher: tea_id , day: 'Saturday'),
                         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                           var snap = snapshot.data;

                           if(snapshot.connectionState == ConnectionState.waiting){
                             return CircularProgressIndicator();
                           }
                           else if (snap.length ==0)
                             {
                               return Text('no data');
                             }
                           else{
                             return Container(
                               height:snap.length*85.0 ,
                               child: ListView.builder(
                                 itemCount: snap.length,

                                 itemBuilder: (_,index){
                                   return Column(
                                     children: [
                                       Container(
                                         padding: const EdgeInsets.only(right: 20),
                                         height: 70,
                                         child: ListTile(
                                           leading: Text(

                                             getClassOrderStrong(snap[index]['schedule_order']),
                                             style: TextStyle(
                                                 fontSize: 12,
                                                 color: Colors.grey,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                           title: Text(
                                             '${getLevelString(snap[index]['lev_id'])} ( ${snap[index]['sec_letter']} )  - ${getSubjectName(snap[index]['sub_id'])}',
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                         ),
                                       ),
                                       Divider(
                                         color: Colors.grey,
                                       ),
                                     ],
                                   );
                                 },
                               ),
                             );
                           }
                         },

                       )


                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
           child: Card(
             shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
               child: Center(
                 child: Theme(
                   data: Theme.of(context)
                       .copyWith(dividerColor: Colors.transparent),
                   child: ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                     tilePadding: EdgeInsets.all(0),
                     title: Padding(
                       padding: const EdgeInsets.only(right: 10),
                       child: Text(
                         'يوم الأحد ',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: kPrimaryColor,
                           fontSize: 15,
                         ),
                       ),
                     ),
                     leading: Image.asset(
                       'images/days/2.png',
                       width: 30,
                     ),
                     children: [
                       Divider(
                         color: Colors.grey,
                       ),
                       FutureBuilder(
                         future: SelectTeacherOneDaySchedule(dep: dep , teacher: tea_id , day: 'Sunday'),
                         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                           var snap = snapshot.data;

                           if(snapshot.connectionState == ConnectionState.waiting){
                             return CircularProgressIndicator();
                           }
                           else if (snap.length ==0)
                           {
                             return Text('no data');
                           }
                           else{
                             return Container(
                               height:snap.length*85.0 ,
                               child: ListView.builder(
                                 itemCount: snap.length,

                                 itemBuilder: (_,index){
                                   return Column(
                                     children: [
                                       Container(
                                         padding: const EdgeInsets.only(right: 20),
                                         height: 70,
                                         child: ListTile(
                                           leading: Text(

                                             getClassOrderStrong(snap[index]['schedule_order']),
                                             style: TextStyle(
                                                 fontSize: 12,
                                                 color: Colors.grey,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                           title: Text(
                                             '${getLevelString(snap[index]['lev_id'])} ( ${snap[index]['sec_letter']} )  - ${getSubjectName(snap[index]['sub_id'])}',
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                         ),
                                       ),
                                       Divider(
                                         color: Colors.grey,
                                       ),
                                     ],
                                   );
                                 },
                               ),
                             );
                           }
                         },

                       )


                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
           child: Card(
             shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
               child: Center(
                 child: Theme(
                   data: Theme.of(context)
                       .copyWith(dividerColor: Colors.transparent),
                   child: ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                     tilePadding: EdgeInsets.all(0),
                     title: Padding(
                       padding: const EdgeInsets.only(right: 10),
                       child: Text(
                         'يوم الاثنين ',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: kPrimaryColor,
                           fontSize: 15,
                         ),
                       ),
                     ),
                     leading: Image.asset(
                       'images/days/3.png',
                       width: 30,
                     ),
                     children: [
                       Divider(
                         color: Colors.grey,
                       ),
                       FutureBuilder(
                         future: SelectTeacherOneDaySchedule(dep: dep , teacher: tea_id , day: 'Monday'),
                         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                           var snap = snapshot.data;

                           if(snapshot.connectionState == ConnectionState.waiting){
                             return CircularProgressIndicator();
                           }
                           else if (snap.length ==0)
                           {
                             return Text('no data');
                           }
                           else{
                             return Container(
                               height:snap.length*85.0 ,
                               child: ListView.builder(
                                 itemCount: snap.length,

                                 itemBuilder: (_,index){
                                   return Column(
                                     children: [
                                       Container(
                                         padding: const EdgeInsets.only(right: 20),
                                         height: 70,
                                         child: ListTile(
                                           leading: Text(

                                             getClassOrderStrong(snap[index]['schedule_order']),
                                             style: TextStyle(
                                                 fontSize: 12,
                                                 color: Colors.grey,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                           title: Text(
                                             '${getLevelString(snap[index]['lev_id'])} ( ${snap[index]['sec_letter']} )  - ${getSubjectName(snap[index]['sub_id'])}',
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                         ),
                                       ),
                                       Divider(
                                         color: Colors.grey,
                                       ),
                                     ],
                                   );
                                 },
                               ),
                             );
                           }
                         },

                       )


                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
           child: Card(
             shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
               child: Center(
                 child: Theme(
                   data: Theme.of(context)
                       .copyWith(dividerColor: Colors.transparent),
                   child: ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                     tilePadding: EdgeInsets.all(0),
                     title: Padding(
                       padding: const EdgeInsets.only(right: 10),
                       child: Text(
                         'يوم الثلاثاء ',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: kPrimaryColor,
                           fontSize: 15,
                         ),
                       ),
                     ),
                     leading: Image.asset(
                       'images/days/4.png',
                       width: 30,
                     ),
                     children: [
                       Divider(
                         color: Colors.grey,
                       ),
                       FutureBuilder(
                         future: SelectTeacherOneDaySchedule(dep: dep , teacher: tea_id , day: 'Tuesday'),
                         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                           var snap = snapshot.data;

                           if(snapshot.connectionState == ConnectionState.waiting){
                             return CircularProgressIndicator();
                           }
                           else if (snap.length ==0)
                           {
                             return Text('no data');
                           }
                           else{
                             return Container(
                               height:snap.length*85.0 ,
                               child: ListView.builder(
                                 itemCount: snap.length,

                                 itemBuilder: (_,index){
                                   return Column(
                                     children: [
                                       Container(
                                         padding: const EdgeInsets.only(right: 20),
                                         height: 70,
                                         child: ListTile(
                                           leading: Text(

                                             getClassOrderStrong(snap[index]['schedule_order']),
                                             style: TextStyle(
                                                 fontSize: 12,
                                                 color: Colors.grey,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                           title: Text(
                                             '${getLevelString(snap[index]['lev_id'])} ( ${snap[index]['sec_letter']} )  - ${getSubjectName(snap[index]['sub_id'])}',
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                         ),
                                       ),
                                       Divider(
                                         color: Colors.grey,
                                       ),
                                     ],
                                   );
                                 },
                               ),
                             );
                           }
                         },

                       )


                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
           child: Card(
             shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
               child: Center(
                 child: Theme(
                   data: Theme.of(context)
                       .copyWith(dividerColor: Colors.transparent),
                   child: ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                     tilePadding: EdgeInsets.all(0),
                     title: Padding(
                       padding: const EdgeInsets.only(right: 10),
                       child: Text(
                         'يوم الأربعاء ',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: kPrimaryColor,
                           fontSize: 15,
                         ),
                       ),
                     ),
                     leading: Image.asset(
                       'images/days/5.png',
                       width: 30,
                     ),
                     children: [
                       Divider(
                         color: Colors.grey,
                       ),
                       FutureBuilder(
                         future: SelectTeacherOneDaySchedule(dep: dep , teacher: tea_id , day: 'Wednesday'),
                         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                           var snap = snapshot.data;

                           if(snapshot.connectionState == ConnectionState.waiting){
                             return CircularProgressIndicator();
                           }
                           else if (snap.length ==0)
                           {
                             return Text('no data');
                           }
                           else{
                             return Container(
                               height:snap.length*85.0 ,
                               child: ListView.builder(
                                 itemCount: snap.length,

                                 itemBuilder: (_,index){
                                   return Column(
                                     children: [
                                       Container(
                                         padding: const EdgeInsets.only(right: 20),
                                         height: 70,
                                         child: ListTile(
                                           leading: Text(

                                             getClassOrderStrong(snap[index]['schedule_order']),
                                             style: TextStyle(
                                                 fontSize: 12,
                                                 color: Colors.grey,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                           title: Text(
                                             '${getLevelString(snap[index]['lev_id'])} ( ${snap[index]['sec_letter']} )  - ${getSubjectName(snap[index]['sub_id'])}',
                                             style: TextStyle(
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                         ),
                                       ),
                                       Divider(
                                         color: Colors.grey,
                                       ),
                                     ],
                                   );
                                 },
                               ),
                             );
                           }
                         },

                       )


                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),

       ]
        ,

      )
    );
  }
}
