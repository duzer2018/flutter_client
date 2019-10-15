import 'package:flutter_client/core/blocs/bloc_auth.dart';
import 'package:flutter_client/core/blocs/bloc_profile.dart';
import 'package:flutter_client/core/blocs/bloc_provider.dart';
import 'package:flutter_client/core/ui/auth/auth_view.dart';
import 'package:flutter_client/core/ui/slider_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: BlocProvider<AuthBloc>(
          bloc: AuthBloc(),
            child: Scaffold(
              body: StreamBuilder(
                stream: AuthBloc().outUserToken,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return SliderView();
                  }else {
                    return LoginPage();
                  }
                  })
            ),
          ),
    );
  }
}
