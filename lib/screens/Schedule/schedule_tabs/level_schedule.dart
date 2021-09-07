import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/Schedule/schedule_tabs/one_level_schedule.dart';
import '../../../constraints.dart';

class LevelsScheduleTab extends StatefulWidget {

  final dep;

  LevelsScheduleTab(this.dep);
  @override
  _LevelsScheduleTabState createState() => _LevelsScheduleTabState(dep);
}

class _LevelsScheduleTabState extends State<LevelsScheduleTab> {
  final dep;

  _LevelsScheduleTabState(this.dep);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SelectDepLevAndSec(dep),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
          var snap = snapshot.data;
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return CircularProgressIndicator();
            }
          else if (!snapshot.hasData)
            {
              return Text('no data ');
            }
          else
            {
              return  ListView.builder(
                itemCount: snap.length,
                itemBuilder: (_,index){
                  return  Card(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      shape:
                      Border(right: BorderSide(color: kPrimaryColor, width: 5)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => OneLevelSchedule(
                                dep: dep ,
                                  section: snap[index]['section_letter'],
                                level: snap[index]['lev_id'],
                              )),
                            );
                          },
                          leading: Image.asset('images/numbers/${snap[index]['lev_id']}.png' , width: 25,),
                          title: Text(
                            getLevelString(snap[index]['lev_id'] ) + '  ( '+snap[index]['section_letter'] + ' ) ',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                  );
                },

              );
            }
        },
      ),
    );
  }
}
