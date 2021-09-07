import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/constraints.dart';
import 'package:supervisor_yemen_glory/models/get_day.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/components/reusable_card.dart';
import 'compliance_level_select.dart';

class DailyComplianceTab extends StatefulWidget {

  final dep_id;
  DailyComplianceTab(this.dep_id);

  @override
  _DailyComplianceTabState createState() => _DailyComplianceTabState(dep_id);
}

class _DailyComplianceTabState extends State<DailyComplianceTab> {
  final dep_id;
  _DailyComplianceTabState(this.dep_id);



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


            return Container(
              child: ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (_, index) {
                    return ReusableCard(
                        colour: Colors.white,
                        cardchild: Row(
                          children: [
                            Text( getDay(snap[index]['dayname']),
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(snap[index]['school_day_date']),
                          ],
                        ),
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ComplianceLevelSelect(
                                date: snap[index]['school_day_date'],date_id: snap[index]['school_day_id'],dep_id: dep_id,),
                          ));
                        },
                        image: 'calender');
                  }),
            );
          }
        },
      );
  }
}
