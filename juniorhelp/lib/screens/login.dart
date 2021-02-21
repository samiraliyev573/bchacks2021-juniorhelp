import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Gradient(
      //   colors: [Color(0xff2ec4b6,Color(0xff495057)]
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7,0.9],
            colors: [
              Color(0xff173d4c),
              Color(0xff118ab2),
              Color(0xff06d6a0),
              Color(0xff06c2a0),
            ],
          ),
        ),
        child: Center(
          child: Column(
              children: [
                SizedBox(height:50),
                Image(
                    image: AssetImage("assets/logo.png"),
                    width: 225,
                ),
                SizedBox(height:20),
                Text(
                    "Log In",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    controller: _emailFieldController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 30,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
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
                          borderSide: BorderSide(
                              color: Colors.white, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        )),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                  child:  FlatButton(
                    onPressed: (){
                      print("aa");
                    },
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)
                      ),
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text('Sign In',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                        fontSize: 20, color: Colors.white),
                  ),
                )
              ],
          ),
        ),
      ),
    );
  }
}
