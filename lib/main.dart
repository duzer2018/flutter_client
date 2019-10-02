import 'package:cdcalctest/core/ui/auth/auth_view.dart';
import 'package:cdcalctest/core/ui/tab_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: LoginPage(),
      ),
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: TabView(),
    );
  }
}