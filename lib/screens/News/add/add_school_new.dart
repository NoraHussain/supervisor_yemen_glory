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
import 'package:supervisor_yemen_glory/networking/add_school_new.dart';
import 'package:supervisor_yemen_glory/networking/add_teacher_new.dart';
import '../../../constraints.dart';


class AddSchoolNewScreen extends StatefulWidget {


  @override
  _AddSchoolNewScreenState createState() => _AddSchoolNewScreenState();
}

class _AddSchoolNewScreenState extends State<AddSchoolNewScreen> {

  dynamic image;
  late File m;

  var _formkey = GlobalKey<FormState>();


  get_image() async {

    var im =  await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      image =  im ;
    });
  }

  late String text ;
  late String title ;
  bool pro = false;


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
          title:  Text('إضافة خبر ' ,style: TextStyle(
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 ,vertical: 20) ,
                  child: TextFormField(
                      onChanged: (v)
                      {
                        title = v.toString();
                      },
                      maxLines: 2,
                      cursorColor: Color(0xffC76BA7),
                      decoration: InputDecoration(
                        hintText: 'العنوان  ',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xFFEEEEEE), width: 2.0),

                        ),
                        fillColor: Color(0xffEEEEEE),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "املأ الحقل ";
                        }
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 20),
                  child: TextFormField(
                      onChanged: (v)
                      {
                        text = v.toString();
                      },
                      maxLines: 7,
                      cursorColor: Color(0xffC76BA7),
                      decoration: InputDecoration(
                        hintText: 'المحتوى  ',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xFFEEEEEE), width: 2.0),

                        ),
                        fillColor: Color(0xffEEEEEE),
                        filled: true,
                      ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: pro, onChanged: (value){
                      setState(() {
                        pro = value!;
                        print(pro.toString());
                      });
                    }),
                    Text('أولوية')
                  ],
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
                        InsertSchoolNewWithImage(m, title, text,pro?'1':'0');

                      }
                      else{
                        print ('nullllllllllllllllllllllllllllllllllllllll');
                        AddSchoolNewWithoutImage(title, text ,pro?'1':'0');
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
