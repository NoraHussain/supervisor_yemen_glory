import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import '../../../constraints.dart';

InsertSchoolNewWithImage(File i , title , text , pro )async {

    var stream = new http.ByteStream(DelegatingStream.typed(i.openRead()));
    var length = await i.length();
    var uri = Uri.parse(ROOT + "insert_school_new.php");

    var request = http.MultipartRequest("POST", uri);
    var multipartfile = http.MultipartFile("image", stream, length,
        filename: basename(i.path));

    request.fields["text"] = text.toString();
    request.fields["title"] = title.toString();
    request.fields["pro"] = pro.toString();
    request.fields["action"] = "add_school_new";

    request.files.add(multipartfile);
    var response = await request.send();

}


AddSchoolNewWithoutImage(title , text , pro ) async{

    print('wow');

    final response = await http.post(
        Uri.parse(ROOT + "insert_school_new.php"), body: {
        "title":  title.toString(),
        "text": text.toString(),
        "pro": pro.toString(),
        "action": "add_school_new",
    });

    print (response.body);
}
