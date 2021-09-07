import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/networking/networking.dart';
import 'package:supervisor_yemen_glory/screens/News/add/add_school_new.dart';
import 'package:supervisor_yemen_glory/screens/News/news_tabs/school_new/new_screen.dart';

import '../../../constraints.dart';
import '../add/add_level_new.dart';

class SchoolNewsTab extends StatefulWidget {
  @override
  _SchoolNewsTabState createState() => _SchoolNewsTabState();
}

class _SchoolNewsTabState extends State<SchoolNewsTab> {
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
            MaterialPageRoute(builder: (_) => AddSchoolNewScreen()),
          );
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .8,
        color: Colors.white,
        child: FutureBuilder(
          future: SelectSchoolNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            var snap2 = snapshot.data;

            if (snapshot == null) {
              return Center(child: Text('noooo data'));
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              return ListView.builder(
                  itemCount: snap2.length,
                  itemBuilder: (_, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: snap2[index]['school_new_image_url'] !=''? Image.network(ROOT +
                                            'news_images/' + snap2[index]['school_new_image_url']):Image.asset('images/logo.png'),


                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 10, top: 8, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: kPrimaryColor,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snap2[index]['date'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          IconButton(onPressed: (){

                                            setState(() {
                                              DeleteSchoolNew(snap2[index]['school_new_id']);
                                            });

                                          }, icon: Icon(Icons.delete , color: Colors.red[700],))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: 10, left: 20, right: 20),
                                      child: Text(
                                        snap2[index]['school_new_title'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) => NewScreen(
                                                        id: snap2[index]
                                                            ['school_new_id'],
                                                        title: snap2[index][
                                                            'school_new_title'],
                                                        date: snap2[index]
                                                            ['date'],
                                                        description: snap2[
                                                                index][
                                                            'school_new_article'],
                                                    image: snap2[
                                                    index][
                                                    'school_new_image_url'],
                                                      )));
                                        },
                                        child: Text(
                                          'قراءة المزيد ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider()
                        ],
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
