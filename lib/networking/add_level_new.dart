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

InsertLevelNewWithImage(File i , text , dep , lev,sec)async {

    var stream = new http.ByteStream(DelegatingStream.typed(i.openRead()));
    var length = await i.length();
    var uri = Uri.parse(ROOT + "insert_level_new.php");

    var request = http.MultipartRequest("POST", uri);
    var multipartfile = http.MultipartFile("image", stream, length,
        filename: basename(i.path));

    request.fields["text"] = text.toString();
    request.fields["dep"] = dep.toString();
    request.fields["lev"] = lev.toString();
    request.fields["sec"] = sec.toString();

    request.fields["action"] = "add_level_new";

    request.files.add(multipartfile);

    var response = await request.send();

}

AddLevelNewWithoutImage(text , dep ,lev,sec) async{

    final response = await http.post(
        Uri.parse(ROOT + "insert_level_new.php"), body: {
        "dep":dep.toString(),
        "lev":lev.toString(),
        "sec":sec.toString(),
        "text": text,
        "action": "add_level_new",
    });

    var u = json.decode(response.body);

    return u;
}
