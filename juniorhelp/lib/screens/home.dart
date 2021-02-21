import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    todolistsubscription = collectionReference.snapshots().listen((event) {
      setState(() {
        todolist = event.docs;
      });
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
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
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
                    padding: EdgeInsets.all(8),
                    itemCount: todolist.length,
                    itemBuilder: (context, index) {
                      String todoName = todolist[index].data()['name'];
                      String todoDate = todolist[index].data()['date'];

                      return Card(
                        color: todolist[index].data()['isChecked']
                            ? Colors.green
                            : Colors.white12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(todoName),
                          subtitle: Text(todoDate),
                          trailing: IconButton(
                              onPressed: () {
                                deleteTask(todolist[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
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
