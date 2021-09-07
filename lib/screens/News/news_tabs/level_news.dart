import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';

import '../../../constraints.dart';
import '../add/add_level_new.dart';

class LevelsNewsTab extends StatefulWidget {

  final dep;
  LevelsNewsTab(this.dep);

  @override
  _LevelsNewsTabState createState() => _LevelsNewsTabState(dep);
}

class _LevelsNewsTabState extends State<LevelsNewsTab> {

  final dep;
  _LevelsNewsTabState(this.dep);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffC76BA7),
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddLevelNewScreen(dep)),
          );
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(

          future: SelectLevelsNews(dep),

          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

            var snap = snapshot.data;

            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return CircularProgressIndicator();
            }
            else if(snap.length==0)
            {
              return Text(
                  'no data'
              );
            }
            else{
              return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Card(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    shape:
                    Border(right: BorderSide(color: kPrimaryColor, width: 5)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Image.asset('images/icons/calender.png',width: 25),

                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    snap[index]['date'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              IconButton(onPressed: (){

                                setState(() {
                                  DeleteLevelNew(snap[index]['level_new_id']);
                                });

                              }, icon: Icon(Icons.delete , color: Colors.red[700],))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 10, left: 20, right: 20, top: 20),
                            child: Column(
                              children: [
                                Text(
                                 getLevelString( snap[index]['lev_id']) + ' ( ' + snap[index]['sec_letter'] + ' ) ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15 , color: kPrimaryColor),
                                ),
                                Text(
                                  snap[index]['level_new_text'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          snap[index]['level_new_image_url']!='' ? Image.network(ROOT+'level_news_images/${snap[index]["level_new_image_url"]}'): Container(),

                        ],
                      ),
                    ),
                  );
                },


              );
            }
          },

        ),
      ),
    );
  }
}
