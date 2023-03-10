// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:app_home_demo/model/db/timetable/timetable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TimeTableInput extends StatefulWidget {
  final String subject, teacher, room;
  final List urlList;
  const TimeTableInput(
      {Key? key,
      required this.subject,
      required this.teacher,
      required this.room,
      required this.urlList})
      : super(key: key);

  @override
  State<TimeTableInput> createState() => _TimeTableInputState();
}

class _TimeTableInputState extends State<TimeTableInput> {
  final subject_value = TextEditingController();
  final teacher_value = TextEditingController();
  final room_value = TextEditingController();
  List infoList1 = [];
  List infoList2 = ['', '', '', '', '', '', ''];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    if (i == 0) {
      subject_value.text = widget.subject;
      teacher_value.text = widget.teacher;
      room_value.text = widget.room;
      infoList2 = widget.urlList;
      i++;
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text('授業登録'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * (8 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (80 / 100),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: subject_value,
                    decoration: const InputDecoration(
                      hintText: '授業名を入力してください',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (80 / 100),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: teacher_value,
                    decoration: const InputDecoration(
                      hintText: '担当教員を入力してください',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (80 / 100),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: room_value,
                    decoration: const InputDecoration(
                      hintText: '教室名を入力してください',
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (5 / 100)),
                const Text('URL登録'),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (1 / 100)),
                Container(
                  height: MediaQuery.of(context).size.height * (15 / 100),
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appButton(
                          filename: 'images/app_icons/classroom_button.png',
                          id: 0,
                          text: 'Classroom'),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 100)),
                      appButton(
                          filename: 'images/app_icons/teams_button.png',
                          id: 1,
                          text: 'Teams'),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 100)),
                      appButton(
                          filename: 'images/app_icons/slack_button.png',
                          id: 2,
                          text: 'Slack'),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 100)),
                      appButton(
                          filename: 'images/app_icons/outlook_button.png',
                          id: 3,
                          text: 'Outlook'),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 100)),
                      appButton(
                          filename: 'images/app_icons/portal_button.png',
                          id: 4,
                          text: 'Portal'),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 100)),
                      appButton(
                          filename: 'images/app_icons/c-learning_button.png',
                          id: 5,
                          text: 'C-Learning'),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 100)),
                      appButton(
                          filename: 'images/app_icons/other_button.png',
                          id: 6,
                          text: 'Other'),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (5 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  child: ElevatedButton(
                    onPressed: () {
                      if (subject_value.text != '') {
                        infoList1 = [
                          subject_value.text,
                          teacher_value.text,
                          room_value.text
                        ];
                        infoList1.addAll(infoList2);
                        Navigator.of(context).pop(infoList1);
                      }
                    },
                    child: const Text('登録'),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (1 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('キャンセル'),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (1 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop([' ']);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('登録情報削除'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget appButton(
      {required String text, required String filename, required int id}) {
    return Tooltip(
      message: text,
      verticalOffset: MediaQuery.of(context).size.width * (8 / 100),
      preferBelow: false,
      child: Container(
        height: MediaQuery.of(context).size.width * (12 / 100),
        width: MediaQuery.of(context).size.width * (12 / 100),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: inkImage(filename: filename, name: text, id: id),
      ),
    );
  }

  Widget inkImage(
      {required String filename, required String name, required int id}) {
    if (infoList2[id] == '') {
      return Ink.image(
        image: AssetImage(filename),
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(80, 40, 40, 40),
          BlendMode.srcATop,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: const Color.fromARGB(50, 0, 0, 0),
          onTap: () async {
            var url = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimeTableUrlInput(url: infoList2[id], name: name)),
            );
            setState(() {
              if (url == null) {
              } else {
                infoList2[id] = url;
              }
            });
          },
        ),
      );
    } else {
      return Ink.image(
        image: AssetImage(filename),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: const Color.fromARGB(50, 0, 0, 0),
          onTap: () async {
            var url = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimeTableUrlInput(url: infoList2[id], name: name)),
            );
            setState(() {
              if (url == null) {
              } else {
                infoList2[id] = url;
              }
            });
          },
        ),
      );
    }
  }
}

class TimeTableUrlInput extends StatefulWidget {
  final String url, name;
  const TimeTableUrlInput({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  State<TimeTableUrlInput> createState() => _TimeTableUrlInputState();
}

class _TimeTableUrlInputState extends State<TimeTableUrlInput> {
  final url_value = TextEditingController();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    if (i == 0) {
      url_value.text = widget.url;
      i++;
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(widget.name),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * (80 / 100),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: url_value,
                    decoration: const InputDecoration(
                      hintText: "URLを入力してください",
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (5 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  child: ElevatedButton(
                    onPressed: () {
                      if (url_value.text != '') {
                        Navigator.of(context).pop(url_value.text);
                      }
                    },
                    child: const Text('登録'),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (1 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('キャンセル'),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * (1 / 100)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop('');
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('登録情報削除'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class RegistInfo extends StatefulWidget {
  RegistInfo({Key? key, required this.result}) : super(key: key);
  List result;

  @override
  State<RegistInfo> createState() => _RegistInfoState();
}

class _RegistInfoState extends State<RegistInfo> {
  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    Color bannerColor = const Color.fromARGB(255, 238, 238, 238);
    if (platformBrightness == Brightness.dark) {
      bannerColor = const Color.fromARGB(255, 70, 70, 70);
    }

    if ((widget.result[0] == '') && (widget.result[1] == '')) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('登録情報'),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * (20 / 100),
            width: double.infinity,
            color: Colors.transparent,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('未登録', style: TextStyle(fontSize: 48)),
                  Text('授業が登録されていません', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('登録情報'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * (1 / 100)),
              Container1(text: '授業名: ${widget.result[0]}'),
              Container1(text: '担当教員: ${widget.result[1]}'),
              Container1(text: '教室名: ${widget.result[2]}'),
              SizedBox(height: MediaQuery.of(context).size.height * (1 / 100)),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * (7 / 100),
                width: double.infinity,
                color: bannerColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('登録URL', style: TextStyle(fontSize: 20)),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('タップして詳細確認', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (2 / 100)),
              for (int i = 3; i < widget.result.length; i++) ...{
                if (widget.result[i] != '') ...{
                  if (i == 3) ...{
                    Container2(
                      title: 'Classroom',
                      url: widget.result[i],
                      filename: 'images/app_icons/classroom.png',
                    ),
                  } else if (i == 4) ...{
                    Container2(
                      title: 'Teams',
                      url: widget.result[i],
                      filename: 'images/app_icons/teams.png',
                    ),
                  } else if (i == 5) ...{
                    Container2(
                      title: 'Slack',
                      url: widget.result[i],
                      filename: 'images/app_icons/slack.png',
                    ),
                  } else if (i == 6) ...{
                    Container2(
                      title: 'Outlook',
                      url: widget.result[i],
                      filename: 'images/app_icons/outlook.png',
                    ),
                  } else if (i == 7) ...{
                    Container2(
                      title: 'OIT Portal',
                      url: widget.result[i],
                      filename: 'images/app_icons/portal.png',
                    ),
                  } else if (i == 8) ...{
                    Container2(
                      title: 'OIT C-Learning',
                      url: widget.result[i],
                      filename: 'images/app_icons/c-learning.png',
                    ),
                  } else if (i == 9) ...{
                    Container2(
                      title: 'その他',
                      url: widget.result[i],
                      filename: 'images/app_icons/other.png',
                    ),
                  }
                }
              }
            ],
          ),
        ),
      );
    }
  }

  Widget Container1({required String text}) {
    return Container(
      height: MediaQuery.of(context).size.height * (4 / 100),
      width: MediaQuery.of(context).size.width * (90 / 100),
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget Container2(
      {required String title, required String url, required String filename}) {
    return Container(
      height: MediaQuery.of(context).size.height * (8 / 100),
      width: MediaQuery.of(context).size.width * (90 / 100),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('登録されているURL'),
                    content: Text(url),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('確認'),
                      )
                    ],
                  );
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(filename),
              SizedBox(width: MediaQuery.of(context).size.width * (5 / 100)),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeTableInput2 extends StatefulWidget {
  const TimeTableInput2({Key? key}) : super(key: key);

  @override
  State<TimeTableInput2> createState() => _TimeTableInput2State();
}

class _TimeTableInput2State extends State<TimeTableInput2> {
  final subject_value = TextEditingController();
  final teacher_value = TextEditingController();
  final room_value = TextEditingController();
  int number = 0;
  List<String> selectedColumnValue = ['0', '0'];
  List<String> selectedRawValue = ['0', '0'];
  List urlList = ['', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('TT');
    var num = '00';
    TTable? val = box.get(num,
        defaultValue: TTable('', '', '', '', '', '', '', '', '', '', ''));
    var Ttsubject = val!.toSubject();
    var Ttteacher = val.toTeacher();
    var Ttroom = val.toRoom();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text('授業登録'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * (8 / 100)),
              SizedBox(
                width: MediaQuery.of(context).size.width * (80 / 100),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: subject_value,
                  decoration: const InputDecoration(
                    hintText: '授業名を入力してください',
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * (80 / 100),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: teacher_value,
                  decoration: const InputDecoration(
                    hintText: '担当教員を入力してください',
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * (80 / 100),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: room_value,
                  decoration: const InputDecoration(
                    hintText: '教室名を入力してください',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * (50 / 100),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: (number + 1),
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          child: SelectButton(number: index),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * (5 / 100)),
                  if (number < 1) ...{
                    SizedBox(
                      child: IconButton(
                        onPressed: () {
                          if (number < 1) {
                            setState(() {
                              number++;
                            });
                          }
                        },
                        icon: const Icon(Icons.add),
                        splashRadius:
                            MediaQuery.of(context).size.width * (5 / 100),
                      ),
                    ),
                  } else if (number == 1) ...{
                    SizedBox(
                      child: IconButton(
                        onPressed: () {
                          if (number == 1) {
                            setState(() {
                              number--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                        splashRadius:
                            MediaQuery.of(context).size.width * (5 / 100),
                      ),
                    ),
                  }
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (5 / 100)),
              const Text('URL登録'),
              SizedBox(height: MediaQuery.of(context).size.height * (1 / 100)),
              Container(
                height: MediaQuery.of(context).size.height * (15 / 100),
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appButton(
                        filename: 'images/app_icons/classroom_button.png',
                        id: 0,
                        text: 'Classroom'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (2 / 100)),
                    appButton(
                        filename: 'images/app_icons/teams_button.png',
                        id: 1,
                        text: 'Teams'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (2 / 100)),
                    appButton(
                        filename: 'images/app_icons/slack_button.png',
                        id: 2,
                        text: 'Slack'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (2 / 100)),
                    appButton(
                        filename: 'images/app_icons/outlook_button.png',
                        id: 3,
                        text: 'Outlook'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (2 / 100)),
                    appButton(
                        filename: 'images/app_icons/portal_button.png',
                        id: 4,
                        text: 'Portal'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (2 / 100)),
                    appButton(
                        filename: 'images/app_icons/c-learning_button.png',
                        id: 5,
                        text: 'C-Learning'),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (2 / 100)),
                    appButton(
                        filename: 'images/app_icons/other_button.png',
                        id: 6,
                        text: 'Other'),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (5 / 100)),
              SizedBox(
                width: MediaQuery.of(context).size.width * (40 / 100),
                child: ElevatedButton(
                  onPressed: () {
                    if (subject_value.text != '') {
                      Ttsubject = subject_value.text;
                      Ttteacher = teacher_value.text;
                      Ttroom = room_value.text;
                      if (number == 0) {
                        box.put(
                          selectedRawValue[0] + selectedColumnValue[0],
                          TTable(
                              Ttsubject,
                              Ttteacher,
                              Ttroom,
                              urlList[0],
                              urlList[1],
                              urlList[2],
                              urlList[3],
                              urlList[4],
                              urlList[5],
                              urlList[6],
                              selectedRawValue[1] + selectedColumnValue[1]),
                        );
                      } else if (number == 1) {
                        box.put(
                          selectedRawValue[0] + selectedColumnValue[0],
                          TTable(
                              Ttsubject,
                              Ttteacher,
                              Ttroom,
                              urlList[0],
                              urlList[1],
                              urlList[2],
                              urlList[3],
                              urlList[4],
                              urlList[5],
                              urlList[6],
                              selectedRawValue[1] + selectedColumnValue[1]),
                        );
                        box.put(
                          selectedRawValue[1] + selectedColumnValue[1],
                          TTable(
                              Ttsubject,
                              Ttteacher,
                              Ttroom,
                              urlList[0],
                              urlList[1],
                              urlList[2],
                              urlList[3],
                              urlList[4],
                              urlList[5],
                              urlList[6],
                              selectedRawValue[0] + selectedColumnValue[0]),
                        );
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('登録'),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (1 / 100)),
              SizedBox(
                width: MediaQuery.of(context).size.width * (40 / 100),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('キャンセル'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SelectButton({required number}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('曜日: '),
        SizedBox(
          width: MediaQuery.of(context).size.width * (10 / 100),
          child: DropdownButton(
            items: const [
              DropdownMenuItem(value: '0', child: Text('月')),
              DropdownMenuItem(value: '1', child: Text('火')),
              DropdownMenuItem(value: '2', child: Text('水')),
              DropdownMenuItem(value: '3', child: Text('木')),
              DropdownMenuItem(value: '4', child: Text('金')),
              DropdownMenuItem(value: '5', child: Text('土')),
            ],
            onChanged: (String? value) {
              setState(() {
                selectedColumnValue[number] = value!;
              });
            },
            value: selectedColumnValue[number],
            isExpanded: true,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * (5 / 100)),
        const Text('時限: '),
        SizedBox(
          width: MediaQuery.of(context).size.width * (10 / 100),
          child: DropdownButton(
            items: const [
              DropdownMenuItem(value: '0', child: Text('1')),
              DropdownMenuItem(value: '1', child: Text('2')),
              DropdownMenuItem(value: '2', child: Text('3')),
              DropdownMenuItem(value: '3', child: Text('4')),
              DropdownMenuItem(value: '4', child: Text('5')),
              DropdownMenuItem(value: '5', child: Text('6')),
              DropdownMenuItem(value: '6', child: Text('7')),
            ],
            onChanged: (String? value) {
              setState(() {
                selectedRawValue[number] = value!;
              });
            },
            value: selectedRawValue[number],
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Widget appButton(
      {required String text, required String filename, required int id}) {
    return Tooltip(
      message: text,
      verticalOffset: MediaQuery.of(context).size.width * (8 / 100),
      preferBelow: false,
      child: Container(
        height: MediaQuery.of(context).size.width * (12 / 100),
        width: MediaQuery.of(context).size.width * (12 / 100),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: inkImage(filename: filename, name: text, id: id),
      ),
    );
  }

  Widget inkImage(
      {required String filename, required String name, required int id}) {
    if (urlList[id] == '') {
      return Ink.image(
        image: AssetImage(filename),
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(80, 40, 40, 40),
          BlendMode.srcATop,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: const Color.fromARGB(50, 0, 0, 0),
          onTap: () async {
            var url = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimeTableUrlInput(url: urlList[id], name: name)),
            );
            setState(() {
              if (url == null) {
              } else {
                urlList[id] = url;
              }
            });
          },
        ),
      );
    } else {
      return Ink.image(
        image: AssetImage(filename),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: const Color.fromARGB(50, 0, 0, 0),
          onTap: () async {
            var url = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimeTableUrlInput(url: urlList[id], name: name)),
            );
            setState(() {
              if (url == null) {
              } else {
                urlList[id] = url;
              }
            });
          },
        ),
      );
    }
  }
}
