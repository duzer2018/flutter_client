import 'package:cdcalctest/core/blocs/bloc_auth.dart';
import 'package:cdcalctest/core/blocs/bloc_profile.dart';
import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/ui/auth/auth_view.dart';
import 'package:cdcalctest/core/ui/tab_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: BlocProvider<AuthBloc>(
          bloc: AuthBloc(),
          child: BlocProvider(
            bloc: ProfileBloc(),
            child: Scaffold(
              body: TabView(),
            ),
          )),
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: TabView(),
    );
  }
}
