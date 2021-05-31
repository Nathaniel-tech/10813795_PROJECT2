import 'package:flutter/material.dart';
import 'package:project_2/firebase/services.dart';
import 'package:project_2/routes/signIn.dart';
import 'routes/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'wrapper.dart';
import 'routes/spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().status,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project_2',
        home: SignIn(),
      ),
    );
  }
}
