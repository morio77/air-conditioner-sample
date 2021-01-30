import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// Firebaseのノードの名前を表すキー
const isPowerOnKey = 'isPowerOn';
const isSentIRKey = 'isSentIR';

class RemoteController extends StatefulWidget {
  @override
  _RemoteControllerState createState() => _RemoteControllerState();
}

class _RemoteControllerState extends State<RemoteController> {

  /// DBへの参照インスタンス
  DatabaseReference _DBRef;

  /// 現在の電源状態（falseで初期化しておく）
  bool isPowerOn = false;

  @override
  void initState() {
    super.initState();
    _DBRef = FirebaseDatabase.instance.reference();
    _DBRef.onChildAdded.listen(_onChildChangedOrAdded);   // 参照するFirebaseにノードが追加されたら実行する関数を追加
    _DBRef.onChildChanged.listen(_onChildChangedOrAdded); // 参照するFirebaseの値が変更されたら実行する関数を追加
  }

  void _onChildChangedOrAdded(Event e) {
    if (e.snapshot.key == isPowerOnKey) {
      setState(() {
        isPowerOn = e.snapshot.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リモコン'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '現在の電源：' + (isPowerOn ? 'ON' : 'OFF'),
            style: TextStyle(fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () => {
                  _DBRef.update({isPowerOnKey: true}),
                  _DBRef.update({isSentIRKey: false}),
                },
                child: Text('電源ON'),
              ),
              RaisedButton(
                onPressed: () => {
                  _DBRef.update({isPowerOnKey: false}),
                  _DBRef.update({isSentIRKey: false}),
                },
                child: Text('電源OFF'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}