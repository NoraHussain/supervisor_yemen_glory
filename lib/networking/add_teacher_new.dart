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
import '../../../constraints.dart';




InsertTeacherNewWithImage(File i , text , dep)async {

    var stream = new http.ByteStream(DelegatingStream.typed(i.openRead()));
    var length = await i.length();
    var uri = Uri.parse(ROOT + "insert_teacher_new.php");

    var request = http.MultipartRequest("POST", uri);
    var multipartfile = http.MultipartFile("image", stream, length,
        filename: basename(i.path));

    request.fields["text"] = text.toString();
    request.fields["dep"] = dep.toString();
    request.fields["action"] = "add_teacher_new";

    request.files.add(multipartfile);
    var response = await request.send();



}

AddTeacherNewWithoutImage(text , dep ) async{

    final response = await http.post(
        Uri.parse(ROOT + "insert_teacher_new.php"), body: {
        "dep":dep.toString(),
        "text": text,
        "action": "add_teacher_new",
    });

    var u = json.decode(response.body);

    return u;
}
