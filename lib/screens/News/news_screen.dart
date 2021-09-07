import 'package:flutter/material.dart';
import 'package:supervisor_yemen_glory/screens/News/news_tabs/school_news.dart';
import 'package:supervisor_yemen_glory/screens/News/news_tabs/teachers_news.dart';

import '../../constraints.dart';
import 'news_tabs/level_news.dart';

class NewsScreen extends StatefulWidget {
  final dep;
  NewsScreen(this.dep);

  @override
  _NewsScreenState createState() => _NewsScreenState(dep);
}

class _NewsScreenState extends State<NewsScreen>
    with TickerProviderStateMixin<NewsScreen> {

  final dep;
  _NewsScreenState(this.dep);

  late TabController atabController;

  @override
  void initState() {
    atabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: TabBar(
          tabs: [
            Tab(
              text: 'أخبار المدرسة  ',
            ),
            Tab(
              text: 'أخبار المدرسين ',
            ),
            Tab(
              text: 'أخبار الصفوف ',
            ),
          ],
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Creates border
              color: kPrimaryColor),
          labelStyle: TextStyle(fontFamily: kPrimaryFont),
          unselectedLabelStyle: TextStyle(fontFamily: kPrimaryFont),
          labelColor: Colors.white,
          unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
          isScrollable: true,
          controller: atabController,
        ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الأخبار  ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: (){
                    setState(() {

                    });
                  }, icon: Icon(
                Icons.refresh
              ))
            ],
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20, top: 10),
        ),
        tabBar,
        Container(
          height: MediaQuery.of(context).size.height * 2 / 3 ,
          child: TabBarView(
            controller: atabController,
            physics: NeverScrollableScrollPhysics(),
            children: [SchoolNewsTab(), TeachersNewsTab(dep), LevelsNewsTab(dep)],
          ),
        )
      ],
    );
  }
}
