import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/components/reusable_card.dart';
import 'package:supervisor_yemen_glory/screens/follow_teacher/daily_teacher_follow_tap/daily_teachers_name.dart';

import '../../../constraints.dart';

class DailyTeacherFollowTap extends StatefulWidget {
  final dep_id;

  DailyTeacherFollowTap (this.dep_id);

  @override
  _DailyTeacherFollowTapState createState() => _DailyTeacherFollowTapState(dep_id);
}

class _DailyTeacherFollowTapState extends State<DailyTeacherFollowTap> {

  final dep_id;

  _DailyTeacherFollowTapState(this.dep_id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SelectSchoolDays(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var snap = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        else if(!snapshot.hasData){
          return Text('no data');
        }

        else {
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

          return Container(
            child: ListView.builder(
                itemCount: snap.length,
                itemBuilder: (_, index) {
                  return ReusableCard(
                      colour: Colors.white,
                      cardchild: Row(
                        children: [
                          Text(
                            GetDay(snap[index]['dayname']),
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(snap[index]['school_day_date']),
                        ],
                      ),
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => DailyTeacherNameScreen(
                                dep_id:dep_id ,
                                day:  snap[index]['dayname'],
                                date: snap[index]['school_day_date'],
                                date_id: snap[index]['school_day_id']
                              )),
                        );
                      },
                      image: 'calender');
                }),
          );
        }
      },
    );
    // Container(
    //   child: ListView.builder(itemBuilder: (_,index){
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 20),
    //       child: Card(
    //           shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    //             child: ListTile(
    //               onTap: (){
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (_) => DailyTeacherNameScreen()),
    //                 );
    //               },
    //               leading:Image.asset('images/icons/calender.png',width: 30,),
    //               title: Row(children: [
    //                 Text('السبت',style: TextStyle(
    //                     color: kPrimaryColor,
    //                     fontWeight: FontWeight.bold
    //                 ),),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //                 Text('1 - 9 - 2020')//'${date.year} - ${date.month} - ${date.day} ')
    //               ]),
    //             ),
    //           )),
    //     );
    //   }),
    // );
  }
}
