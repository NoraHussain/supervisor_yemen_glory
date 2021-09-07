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
import 'package:supervisor_yemen_glory/networking/add_teacher_new.dart';
import '../../../constraints.dart';


class AddTeacherNewScreen extends StatefulWidget {

  final dep;

  AddTeacherNewScreen(this.dep);

  @override
  _AddTeacherNewScreenState createState() => _AddTeacherNewScreenState(dep);
}

class _AddTeacherNewScreenState extends State<AddTeacherNewScreen> {

   dynamic image;
   late File m;

  _AddTeacherNewScreenState(this.dep);

  var _formkey = GlobalKey<FormState>();


  final dep;

   get_image() async {

     var im =  await ImagePicker().getImage(source: ImageSource.gallery);


     setState(() {
      image =  im ;



    });
  }

  late String t ;


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
          title:  Text('إضافة خبر للمدرسين' ,style: TextStyle(
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
                        InsertTeacherNewWithImage(m, t, dep);

                     }
                     else{
                       print ('nullllllllllllllllllllllllllllllllllllllll');
                        AddTeacherNewWithoutImage( t, dep);
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
