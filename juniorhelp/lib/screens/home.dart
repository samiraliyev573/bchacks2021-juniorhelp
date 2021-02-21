import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DocumentSnapshot> todolist;
  StreamSubscription<QuerySnapshot> todolistsubscription;
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('todos');
  String name = "";
  String date = "";

  DateTime _now = DateTime.now();
  String _time = "";

  @override
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackbar(Map<String, dynamic> message){
    dynamic notifText = message['notification'];
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            notifText["body"],
            style: TextStyle(
                fontSize: 17
            ),
          ),
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'OK'
          ),
        )
    );
  }

  void initState() {
    super.initState();
    init();
    _time = DateFormat('HH:mm').format(_now);
    todolistsubscription = collectionReference.snapshots().listen((event) {
      setState(() {
        todolist = event.docs;
      });
    });
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showSnackbar(message);
          print("onLaunch: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
        }
    );

  }
  bool _initialized = false;
  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }

  @override
  void dispose() {
    todolistsubscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference list = FirebaseFirestore.instance.collection('todos');
    Future<void> addTask(String name, String date) {
      return list.add({
        'name': name,
        'date': date,
        'isChecked': false,
      }).catchError((onError) => print("Failed to add task $onError"));
    }

    Future<void> deleteTask(String documentId) {
      return list
          .doc(documentId)
          .delete()
          .catchError((onError) => print("Failed to delete task $onError"));
    }

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: Color(0xff118ab2),
          onPressed: () {
            Alert(
                context: context,
                title: "Task for Senior",
                content: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.check),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: 'Date',
                      ),
                      onChanged: (value) {
                        date = value;
                      },
                    ),
                    GestureDetector(
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
                          width: 200,
                          decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                              color: Colors.transparent
                          ),
                          child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Time:",style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey
                                )
                                ),
                                FlatButton(
                                  child: Text(
                                      _time,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey
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
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      addTask(name, date);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }, //addTask("Take your insulin", "Feb 20, 11:00 AM"),
          child: Icon(
              Icons.add,
              size: 43,
              color: Colors.white
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Memory",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      color: Colors.green,
                      child: Text(
                        "Jogger",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            todolist != null
                ? Expanded(
                    child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemCount: todolist.length,
                    itemBuilder: (context, index) {
                      String todoName = todolist[index].data()['name'];
                      String todoDate = todolist[index].data()['date'];

                      return Card(
                        elevation: 5,
                        color: todolist[index].data()['isChecked']
                            ? Color(0xff2ec4b6)
                            : Color(0xff495057),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: ListTile(
                          title: Text(
                              todoName,
                            style: TextStyle(
                              fontSize: 21,
                                color: Colors.white
                            ),
                          ),
                          subtitle:Text(
                            todoDate,
                            style: TextStyle(
                                fontSize: 19,
                              color: Colors.white70
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                deleteTask(todolist[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                  color: Colors.white70
                              )),
                        ),
                      );
                    },
                  ))
                : Expanded(
                    child: Container(
                    child: Center(
                      child: Text("Todo List is Empty"),
                    ),
                  ))
          ],
        ),
      ),
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
