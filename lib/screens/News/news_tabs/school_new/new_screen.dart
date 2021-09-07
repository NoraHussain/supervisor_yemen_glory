import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constraints.dart';

class NewScreen extends StatefulWidget {

  final id;
  final title;
  final description;
  final date;
  final image;

  NewScreen({this.id, this.title, this.date, this.description,this.image});

  @override
  _NewScreenState createState() =>
      _NewScreenState(id, title, date, description,image);
}

class _NewScreenState extends State<NewScreen>
    with TickerProviderStateMixin<NewScreen> {
  _NewScreenState(this.id, this.title, this.date, this.description,this.image);
  final id;
  final title;
  final description;
  final date;
  final image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 17,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: kPrimaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: MediaQuery.of(context).size.height / 3,
                          child: Container(
                                        padding: EdgeInsets.all(20),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                ROOT +'news_images/$image',
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                        foregroundDecoration: BoxDecoration(
                                            color: Color(0x22000000)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                      ));

                      },
                      childCount: 1,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            description,
                            style: TextStyle(color: Colors.grey.shade900),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              )
    );
  }
}
