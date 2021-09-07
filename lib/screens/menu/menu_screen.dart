import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/screens/auth/login_screen.dart';

import '../../constraints.dart';


class MenuScreen extends StatefulWidget {



  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
            color: kLightGrey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'القائمة  ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20, top: 10, bottom: 8),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [

                          ListTile(
                            leading: Image.asset(
                              'images/icons/school.png',
                              width: 25,
                            ),
                            title: Text(
                              'عن المدرسة',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                            },
                          ),
                          Divider(
                            thickness: 1,
                            indent: 60,
                          ),
                          InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Image.asset(
                                'images/icons/programmer.png',
                                width: 25,
                              ),
                              title: Text(
                                'عن مطور التطبيق',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 60,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => LoginScreen()));
                            },
                            child: ListTile(
                              leading: Image.asset(
                                'images/icons/log-out.png',
                                width: 25,
                              ),
                              title: Text(
                                'تسجيل الخروج',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

  }
}
