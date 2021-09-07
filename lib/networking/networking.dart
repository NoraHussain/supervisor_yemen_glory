import "package:http/http.dart" as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../constraints.dart';

Future<int> login(String phoneNumber, String password) async {
  try {
    final response = await http.post(Uri.parse( ROOT+'supervisor_yemen_glory.php'),
        body: {"phone": phoneNumber, "password": password, "action": 'login'});

    if (response.statusCode == 200) {
      var userdata = json.decode(response.body);

      if (userdata.length == 0) {
        return 0;
      }

      else {
        return int.parse(userdata[0]['supervisor_id']);
      }
    } else {
      return -1;
    }
  } on SocketException catch (_) {
    print("Error Happend");

    return -1;

  }
}

//


SelectDepId(sup) async {

  final response = await http.post(
    Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
    body: {"action": 'select_dep_id', 'sup': sup.toString()},
  );

  var dep_id = json.decode(response.body);

  print(dep_id);

  return dep_id[0]['department_id'];

}



SelectSchoolNews() async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'select_school_news'});

  var news = json.decode(response.body);

  return news;
}


DeleteSchoolNew(new_id) async {

  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'delete_school_new', 'new_id': new_id});
  return ['ok'];
}


SelectTeacherNews(dep) async {
  final response = await http.post(
    Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
    body: {"action": 'select_teachers_news', 'dep': dep.toString()},
  );

  var news = json.decode(response.body);

  print(news);

  return news;
}

DeleteTeachersNew(new_id) async {

  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'delete_teachers_new', 'new_id': new_id});
  return ['ok'];
}

SelectLevelsNews(dep) async {
  final response = await http.post(
    Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
    body: {"action": 'select_levels_news', 'dep': dep.toString()},
  );

  var news = json.decode(response.body);

  print(news);

  return news;
}

DeleteLevelNew(new_id) async {

  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'delete_levels_new', 'new_id': new_id});
  return ['ok'];
}

SelectSchoolDays() async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'select_school_days'});

  var days = json.decode(response.body);

  return days;
}

InsertSchoolDay(DateTime date) async {
  String d = '${date.year}-${date.month}-${date.day}';

  print(d);
  try {
    final response = await http.post(
        Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
        body: {"action": 'insert_school_day', 'date': d});

    var day = json.decode(response.body);
    print(day);

    return 1;
  } on SocketException catch (e) {
    print(e);
    return 0;
  }
}



SelectDepLevAndSec(dep_id) async {
  final response = await http
      .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_department_level_section',
    'dep_id': dep_id.toString()
  });

  var levels = json.decode(response.body);

  print(levels[1]['section_letter']);

  return levels;
}

//

SelectDepLevSevStudents(dep, lev, sec) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_dep_lev_sec_students',
    'dep_id': dep.toString(),
    'sec_letter': sec.toString(),
    'lev_id': lev.toString()
  });

  var students = json.decode(response.body);

  return students;
}

SelectAbsentStudent(date) async {
  final response = await http
      .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_day_absent_students',
    'date_id': date.toString()
  });

  var students_id = json.decode(response.body);

  //print(levels[1]['section_letter']);

  return students_id;
}

AddNewAbsentStudentRecord(date_id, List<dynamic> students) async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'delete_pre_absent_record', 'date_id': date_id});

  for (var student in students) {
    final response = await http
        .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
      "action": 'insert_absent_student',
      'date_id': date_id,
      'stu_id': student
    });
    print(student);
  }
}

SelectLateStudent(date) async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'select_day_late_students', 'date_id': date.toString()});

  var students_id = json.decode(response.body);

  //print(levels[1]['section_letter']);

  return students_id;
}

AddNewLateStudentRecord(date_id, List<dynamic> students) async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'delete_pre_lateness_record', 'date_id': date_id});

  for (var student in students) {
    final response = await http
        .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
      "action": 'insert_late_student',
      'date_id': date_id,
      'stu_id': student
    });
    print(student);
  }
}

SelectUniVioStudent(date) async {
  final response = await http
      .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_day_univio_students',
    'date_id': date.toString()
  });

  var students_id = json.decode(response.body);

  //print(levels[1]['section_letter']);

  return students_id;
}

AddNewUniVioStudentRecord(date_id, List<dynamic> students) async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'delete_pre_univio_record', 'date_id': date_id});

  for (var student in students) {
    final response = await http
        .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
      "action": 'insert_univio_student',
      'date_id': date_id,
      'stu_id': student
    });
    print(student);
  }
}

//

SelectOffenses(dep_id) async {
  final response = await http
      .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_dep_students_offenses',
    'dep_id': dep_id.toString()
  });

  var offs = await json.decode(response.body);

  return offs;
}

SelectDepTeachers(dep_id) async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'select_dep_teachers', 'dep_id': dep_id.toString()});

  var offs = await json.decode(response.body);

  return offs;
}

//

SelectDepTeacherDayClasses(dep_id, tea_id, day) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_dep_teacher_day_classes',
    'dep_id': dep_id.toString(),
    'tea_id': tea_id,
    'day': day
  });

  var offs = await json.decode(response.body);

  return offs;
}

SelectAbsentTeacherClasses(date, teacher) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_teacher_absence_classes',
    'date_id': date.toString(),
    'tea_id': teacher.toString()
  });

  var classes = json.decode(response.body);

  return classes;
}

AddNewAbsentTeacherClassesRecord({date_id, classes, teacher}) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'delete_pre_teacher_absent_record',
    'date_id': date_id,
    'tea_id': teacher
  });

  for (var c in classes) {
    final response =
        await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
      "action": 'insert_absent_teacher_class',
      'date_id': date_id,
      'class_id': c,
      'tea_id': teacher
    });
  }
}

//

SelectNoPrepTeacherClasses(date, teacher) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_teacher_no_prep_classes',
    'date_id': date.toString(),
    'tea_id': teacher.toString()
  });

  var classes = json.decode(response.body);

  return classes;
}

AddNewNoPrepTeacherClassesRecord({date_id, classes, teacher}) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'delete_pre_teacher_no_prep_record',
    'date_id': date_id,
    'tea_id': teacher
  });

  for (var c in classes) {
    final response =
        await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
      "action": 'insert_no_prep_teacher_class',
      'date_id': date_id,
      'class_id': c,
      'tea_id': teacher
    });
  }
}

///
///
SelectNoAidTeacherClasses(date, teacher) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_teacher_no_aid_classes',
    'date_id': date.toString(),
    'tea_id': teacher.toString()
  });

  var classes = json.decode(response.body);

  return classes;
}

AddNewNoAidTeacherClassesRecord({date_id, classes, teacher}) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'delete_pre_teacher_no_aid_record',
    'date_id': date_id,
    'tea_id': teacher
  });

  for (var c in classes) {
    final response =
        await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
      "action": 'insert_no_aid_teacher_class',
      'date_id': date_id,
      'class_id': c,
      'tea_id': teacher
    });
  }
}

SelectMonths() async {
  final response = await http.post(
      Uri.parse(ROOT + 'supervisor_yemen_glory.php'),
      body: {"action": 'select_school_months'});

  var months = json.decode(response.body);

  return months;
}

//
SelectTeacherLevels({dep, teacher}) async {
  final response = await http
      .post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_teacher_levels',
    'dep_id': dep,
    'tea_id': teacher
  });

  var data = json.decode(response.body);

  return data;
}

SelectTeacherLevelSubjects({dep, teacher, level, section}) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_teacher_level_subjects',
    'dep_id': dep.toString(),
    'tea_id': teacher.toString(),
    'lev_id': level.toString(),
    'sec_letter': section.toString()
  });

  var data = json.decode(response.body);

  return data;
}

SelectTeacherOneDaySchedule({dep, teacher, day}) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_teacher_one_day_schedule',
    'dep_id': dep.toString(),
    'tea_id': teacher.toString(),
    'day': day
  });

  var data = json.decode(response.body);

  print(data);

  return data;
}

SelectLevelOneDaySchedule({dep, level, day, section}) async {
  final response =
      await http.post(Uri.parse(ROOT + 'supervisor_yemen_glory.php'), body: {
    "action": 'select_level_one_day_schedule',
    'dep_id': dep.toString(),
    'lev_id': level.toString(),
    'sec_letter': section.toString(),
    'day': day
  });

  var data = json.decode(response.body);

  print(data);

  return data;
}
