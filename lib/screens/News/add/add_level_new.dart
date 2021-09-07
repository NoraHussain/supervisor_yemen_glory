import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:supervisor_yemen_glory/models/get_level_name.dart';
import 'package:supervisor_yemen_glory/networking/add_level_new.dart';
import 'package:supervisor_yemen_glory/networking/add_teacher_new.dart';
import '../../../constraints.dart';


class AddLevelNewScreen extends StatefulWidget {

  final dep;

  AddLevelNewScreen(this.dep);

  @override
  _AddLevelNewScreenState createState() => _AddLevelNewScreenState(dep);
}

class _AddLevelNewScreenState extends State<AddLevelNewScreen> {

  dynamic image;
  late File m;

 var levels = [
   '1','2','3','4','5','6','7','8','9','10','11','12'
 ];


  String selectedLevel = '1';


  _AddLevelNewScreenState(this.dep);

  var _formkey = GlobalKey<FormState>();
  final dep;

  get_image() async {

    var im =  await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      image =  im ;



    });
  }

  late String t ;
  late String s;


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title:  Text('إضافة خبر للطلاب' ,style: TextStyle(
              fontSize: 17,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold
          ),),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'إلغاء',
                style: TextStyle(color: kPrimaryColor),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  
                  Expanded(
                    child: DropdownButton(

                    items: levels.map((itemname) {
                      return DropdownMenuItem(
                          value: itemname,
                          child: Text(
                        getLevelString(itemname)
                      ));
                    }).toList(),
                      onChanged: (v){
                      setState(() {
                        selectedLevel = v.toString();
                      });
                      },
                      value: selectedLevel,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLength: 1,
                        onChanged: (v)
                        {
                          s = v.toString();
                        },
                        cursorColor: Color(0xffC76BA7),
                        decoration: InputDecoration(
                          hintText: 'الشعبة  ',

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xFFEEEEEE), width: 2.0),

                          ),


                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "املأ الحقل ";
                          }
                        }
                    ),
                  ),
                ],
              ),

            ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                      onChanged: (v)
                      {
                        t = v.toString();
                      },
                      maxLines: 8,
                      cursorColor: Color(0xffC76BA7),
                      decoration: InputDecoration(
                        hintText: 'المحتوى  ',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xFFEEEEEE), width: 2.0),

                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "املأ الحقل ";
                        }
                      }
                  ),
                ),
                Container(

                  child: TextButton(
                    onPressed:() async {
                      await get_image();
                      print('pppppppppppppppppppppppppppppp');
                      print('path : '+image.path);
                      m = File(image.path);

                    },

                    child: image ==null?
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child:Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey,
                      ),
                      radius: 60,

                    ):
                    CircleAvatar(
                        child:Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey,
                        ),
                        radius: 60,
                        backgroundImage: FileImage(m)),

                  ),
                ),


                TextButton(

                  onPressed: ()  {

                    if (_formkey.currentState!.validate()) {
                      if(image!=null) {
                        InsertLevelNewWithImage(m, t, dep,selectedLevel,s);

                      }
                      else{
                        print ('nullllllllllllllllllllllllllllllllllllllll');
                        print(selectedLevel);
                        AddLevelNewWithoutImage( t, dep,selectedLevel,s);
                      }


                      Navigator.pop(context);


                      print('great');

                    }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffC76BA7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.all(20),
                      child: Text(
                        'إرسال',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
