import 'package:flutter/material.dart';
import 'package:juniorhelp/main.dart';
import 'package:juniorhelp/screens/home.dart';
import 'package:juniorhelp/screens/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Gradient(
      //   colors: [Color(0xff2ec4b6,Color(0xff495057)]
      // ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100,
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 200,
                ),
              ),
              SizedBox(height: 20),
              Text("Sign Up",
                  style: TextStyle(fontSize: 40, color: Colors.white)),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  controller: _emailFieldController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 30,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  controller: _passwordFieldController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BottomNav();
                    }));
                  },
                  color: Colors.transparent,
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text('Sign Up',
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                child: Text(
                  "Already have an account? Sign In",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
