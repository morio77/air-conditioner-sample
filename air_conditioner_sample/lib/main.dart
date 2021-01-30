import 'package:flutter/material.dart';

import 'remote_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'エアコンのリモコン',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RemoteController(),
    );
  }
}


