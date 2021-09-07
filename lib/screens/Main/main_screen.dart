import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/screens/News/news_screen.dart';
import 'package:supervisor_yemen_glory/screens/Schedule/schedule_screen.dart';
import 'package:supervisor_yemen_glory/screens/follow_student/follow_student_screen.dart';
import 'package:supervisor_yemen_glory/screens/follow_teacher/follow_teacher.dart';
import 'package:supervisor_yemen_glory/screens/menu/menu_screen.dart';
import '../../constraints.dart';

class MainScreen extends StatefulWidget {

  MainScreen(this.supervisor_id,this.dep_id);

  final dep_id;
  final supervisor_id;

  static const id = "main";
  @override
  _MainScreenState createState() => _MainScreenState(supervisor_id,dep_id);
}


class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin<MainScreen> {

  _MainScreenState(this.supervisor_id,this.dep_id);

  final dep_id;
  final supervisor_id;


  late TabController topTabController; //1


  @override
  void initState() {
    topTabController = TabController(length: 5, vsync: this); //2

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '  مدارس مجد اليمن الحديثة',
          style: TextStyle(
              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(onPressed: (){
            setState(() {

            });
          }, icon: Icon(Icons.refresh,color: kPrimaryColor,))

        ],
      ),
      body: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(color: Color(0xffAAAAAA), height: 1.0),
              preferredSize: Size.fromHeight(1.0)),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: topTabController.index == 0
                      ? Image.asset(

                    'images/icons/a_news.png',
                    width: 30,
                  )
                      : Image.asset(
                    'images/icons/u_news.png',
                    width: 30,
                  ),
                  onTap: () {
                    setState(() {
                      topTabController.animateTo(0); //3
                    }
                    );
                  },
                ),
                InkWell(
                  child: topTabController.index == 1
                      ? Image.asset(
                    'images/icons/a_student.png',
                    width: 30,
                  )
                      : Image.asset(
                    'images/icons/u_student.png',
                    width: 30,
                  ),
                  onTap: () {
                    setState(() {
                      topTabController.animateTo(1); //3
                    });
                  },
                ),
                InkWell(
                  child: topTabController.index == 2
                      ? Image.asset(
                    'images/icons/a_teacher.png',
                    width: 30,
                  )
                      : Image.asset(
                    'images/icons/u_teacher.png',
                    width: 30,
                  ),
                  onTap: () {
                    setState(() {
                      topTabController.animateTo(2); //3
                    });
                  },
                ),
                InkWell(
                  child: topTabController.index == 3
                      ? Image.asset(
                    'images/icons/a_schedule.png',
                    width: 30,
                  )
                      : Image.asset(
                    'images/icons/u_schedule.png',
                    width: 30,
                  ),
                  onTap: () {
                    setState(() {
                      topTabController.animateTo(3); //3
                    });
                  },
                ),
                InkWell(
                  child: topTabController.index == 4
                      ? Image.asset(
                    'images/icons/a_menu.png',
                    width: 30,
                  )
                      : Image.asset(
                    'images/icons/u_menu.png',
                    width: 30,
                  ),
                  onTap: () {
                    setState(() {
                      topTabController.animateTo(4); //3
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: topTabController, //5
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            NewsScreen(dep_id),
            FollowStudentsScreen(dep_id),
            FollowTeachersScreen(dep_id),
            ScheduleScreen(dep_id),
            MenuScreen(),
          ],
        ),
      ),
    );
  }
}
