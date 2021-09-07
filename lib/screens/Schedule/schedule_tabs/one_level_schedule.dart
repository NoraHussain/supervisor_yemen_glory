import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/models/get_class_order_string.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/models/get_subject_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';

import '../../../constraints.dart';

class OneLevelSchedule extends StatefulWidget {

  final dep;
  final section;
  final level;

  OneLevelSchedule({
    this.dep ,
    this.level ,
    this.section
});

  @override
  _OneLevelScheduleState createState() => _OneLevelScheduleState(
    dep: dep,
    section: section,
    level: level
  );
}

class _OneLevelScheduleState extends State<OneLevelSchedule> {

  final dep;
  final section;
  final level;

  _OneLevelScheduleState({
    this.dep ,
    this.level ,
    this.section
  });

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
            ' ${getLevelString(level)}  ( ${section} )',
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
                            future: SelectLevelOneDaySchedule( dep: dep , section: section ,level: level , day: 'Saturday'),
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
                                                '  ${getSubjectName(snap[index]['sub_id'])}',
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
                            future: SelectLevelOneDaySchedule( dep: dep , section: section ,level: level , day: 'Sunday'),
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
                                                '  ${getSubjectName(snap[index]['sub_id'])}',
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
                            future: SelectLevelOneDaySchedule( dep: dep , section: section ,level: level , day: 'Monday'),
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
                                                '  ${getSubjectName(snap[index]['sub_id'])}',
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
                            future: SelectLevelOneDaySchedule( dep: dep , section: section ,level: level , day: 'Tuesday'),
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
                                                '  ${getSubjectName(snap[index]['sub_id'])}',
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
                            future: SelectLevelOneDaySchedule( dep: dep , section: section ,level: level , day: 'Wednesday' , ),
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
                                                '  ${getSubjectName(snap[index]['sub_id'])}',
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
