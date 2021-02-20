import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:juniorhelp/services/addToDo.dart';
import 'package:juniorhelp/models/task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double _mediaHeight;
  double _mediaWidth;
  Task t1 = Task(task:"Take Pills",time:"20:00",done:false);
  Task t2 = Task(task:"Take a walk",time:"24:00",done:false);
  Task t3 = Task(task:"Take dog",time:"25:00",done:false);
  Task t4 = Task(task:"Sleep",time:"26:00",done:false);

  List<Task> toDos = [Task(task:"",time:"",done:false)];
  void initState(){
    setState(() {
      toDos = [t1,t2,t3,t4];
    });
  }

  bool _swicthValue = false;
  @override
  Widget build(BuildContext context) {
    
    _mediaHeight = MediaQuery.of(context).size.height;
    _mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
            'Home',
          style: TextStyle(
            color: Color(0xff5a5a5a),
            fontSize: 25
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          for(int i=0;i<toDos.length;i++)...{
            Center(
              child: Container(
                width: _mediaWidth*0.9,
                height: 65,
                child: SizedBox.expand(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              toDos[i].task,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff5a5a5a)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              toDos[i].done = !toDos[i].done;
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(right:20),
                            width: 40,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              color: (!toDos[i].done) ? Colors.white : Color(0xff38d7b2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
          },
          Container(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                child: Text(
                    "+",
                  style: TextStyle(fontSize: 40),
                ),
                splashColor: Colors.indigo,
                elevation: 8,
                backgroundColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addToDo(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )
    );
  }
}
