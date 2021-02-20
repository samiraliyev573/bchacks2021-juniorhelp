import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:juniorhelp/models/task.dart';

class addToDo extends StatefulWidget {
  @override
  _addToDoState createState() => _addToDoState();
}

class _addToDoState extends State<addToDo> {

  double _mediaHeight;
  double _mediaWidth;
  DateTime _now = DateTime.now();
  String _time ="22:10";

  final _taskFieldController = TextEditingController();

  Task generateTask(){
    // Task newTask = _taskFieldController.text;
  }

  @override
  Widget build(BuildContext context) {
    _mediaHeight = MediaQuery.of(context).size.height;
    _mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Add a Task',
          style: TextStyle(
              color: Color(0xff5a5a5a),
              fontSize: 25
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:_mediaWidth*0.05),
            child: TextField(
              cursorColor: Color(0xff5a5a5a),
              style: TextStyle(
                color: Color(0xff5a5a5a),
                fontSize: 20,
              ),
              controller: _taskFieldController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left:7),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5a5a5a), width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "Task",
                  hintStyle: TextStyle(
                      fontSize: 20.0, color: Color(0xff5a5a5a)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff5a5a5a),
                        width: 2.0),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: _mediaHeight*0.04,horizontal: _mediaWidth*0.04),
            child: GestureDetector(
              onTap: () {
                DatePicker.showPicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                      String timeHour = time.hour.toString();
                      if(time.hour<10){
                        timeHour = "0"+time.hour.toString();
                      }
                      setState(() {
                        if(time.minute<10){
                          _time = '${timeHour}:0${time.minute}';
                        }else{
                          _time = '${timeHour}:${time.minute}';
                        }
                      });
                    },
                    pickerModel: CustomPicker(currentTime: DateTime.now()),
                    locale: LocaleType.az
                );
              },
              child: Container(
                width: _mediaWidth*0.91,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border(bottom: BorderSide(color: Color(0xff5a5a5a))),
                    color: Colors.transparent
                ),
                child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Time:",style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff5a5a5a)
                      )
                      ),
                      FlatButton(
                        child: Text(
                            _time,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff5a5a5a)
                            )
                        ),
                        onPressed: () {
                          DatePicker.showPicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (time) {
                                setState(() {
                                  if(time.minute<10){
                                    _time = '${time.hour}:0${time.minute}';
                                  }else{
                                    _time = '${time.hour}:${time.minute}';
                                  }
                                });
                              },
                              pickerModel: CustomPicker(currentTime: DateTime.now()),
                              locale: LocaleType.az
                          );
                        },
                      ),
                    ]
                ),
              ),
            ),
          ),
          FlatButton(
              onPressed: () {
                generateTask();
              },
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(12),
                height: 50,
                width: _mediaWidth*0.8,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color(0xff577590)
                ),
                child: Center(
                  child: Text('Save',
                      style:  TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      )
                  ),
                ),
              ),
          )
        ],
      )
    );
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "";
  }

  @override
  String rightDivider() {
    return ":";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 0]; //only hour and minute will be shown
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        this.currentLeftIndex(),
        this.currentMiddleIndex(),
        this.currentRightIndex())
        : DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        this.currentLeftIndex(),
        this.currentMiddleIndex(),
        this.currentRightIndex());
  }
}
