import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_2/firebase/services.dart';
import 'signup.dart';
import 'spinkit.dart';
import 'dashboard.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final email = new TextEditingController();
  final password = new TextEditingController();

  final AuthService _auth = new AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                          "SIGN IN",
                          style: TextStyle(
                              color: Colors.pink, fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: email,
                                validator: (val) =>
                                    val.isEmpty ? 'Email is required' : null,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle:
                                      TextStyle(color: Colors.pink),
                                  
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            //Password Field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                obscureText: true,
                                controller: password,
                                validator: (val) =>
                                    val.isEmpty ? 'Password is required' : null,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle:
                                      TextStyle(color: Colors.pink),
                                  
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            //Sign In Button
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  dynamic result = await _auth.signIn(
                                      email.text, password.text);
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => Dashboard()));
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
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
                                          "SIGN IN",
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
                            SizedBox(height: 20),

                            
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Text("Don't have an account?"),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: FlatButton(
                                      child: Text(
                                        "Register Here",
                                        style: TextStyle(
                                            color: Colors.pink),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
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
