import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2/firebase/services.dart';
import 'signIn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'spinkit.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controllers
  final fname = new TextEditingController();
  final lname = new TextEditingController();
  final email = new TextEditingController();
  final pass1 = new TextEditingController();
  final pass2 = new TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<FirebaseUser>(context);

    return SafeArea(
      child: isLoading
          ? Loading()
          : Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.pink, fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            //First Name
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: fname,
                                validator: (val) => val.isEmpty
                                    ? 'Username is required'
                                    : null,
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  labelStyle:
                                      TextStyle(color: Colors.pink),
                               
                                ),
                              ),
                            ),
                            SizedBox(height: 12),


                            //Email
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: email,
                                validator: (val) =>
                                    val.isEmpty ? 'E-mail is required' : null,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle:
                                      TextStyle(color: Colors.pink),
                                  
                                ),
                              ),
                            ),
                            SizedBox(height: 12),

                            //Password Field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                obscureText: true,
                                controller: pass1,
                                validator: (val) =>
                                    val.isEmpty ? 'Password is required' : null,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle:
                                      TextStyle(color: Colors.pink),
                                  
                                ),
                              ),
                            ),
                            SizedBox(height: 12),

                            //Confirm password
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                obscureText: true,
                                controller: pass2,
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null,
                                decoration: InputDecoration(
                                  labelText: "Confrim Password",
                                  labelStyle:
                                      TextStyle(color: Colors.pink),
                                  
                                ),
                              ),
                            ),
                            SizedBox(height: 12),

                            //Sign Up Button
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  if (pass1.text == pass2.text) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    //register user
                                    dynamic result = await _auth.register(
                                        email.text, pass1.text);
                                    //Store details
                                    if (result != null) {
                                      await _auth.userInfo(
                                          fname.text);
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  Dashboard()));
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "SIGN UP",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        
                                      ],
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Already have an account?"),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: FlatButton(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.pink),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
