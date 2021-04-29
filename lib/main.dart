import 'package:flutter/material.dart';
import 'requests.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController c_shift = new TextEditingController();
  TextEditingController c_text = new TextEditingController();

  Future<Response> store;
  String _text = '';

  void _decryptText() {
    setState(() {
      store = decipher(int.parse(c_shift.text), c_text.text);
    });
  }

  void _encryptText() {
    setState(() {
      store = cipher(int.parse(c_shift.text), c_text.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: c_shift,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Cipher Key'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: c_text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Text'),
                ),
              ),
            ),
            FutureBuilder<Response>(
              future: store,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.result);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            IconButton(
              icon: Icon(Icons.architecture_outlined),
              iconSize: 48,
              onPressed: encryptText(),
            ),
          ],
        ),
      ),
    );
  }
}
