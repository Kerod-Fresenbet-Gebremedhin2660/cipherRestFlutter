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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Caesarean Cipher'),
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
  TextEditingController cShift = new TextEditingController();
  TextEditingController cText = new TextEditingController();

  Response store;
  String _text = 'PlaceHolder';

  void getText() async {
    _text = await decryptText();
    setter();
  }

  void setter() {
    setState(() {
      _text;
    });
  }

  Future<String> decryptText() async {
    store = await Response.decipher(int.parse(cShift.text), cText.text);
    var result = store.result;
    return result;
  }

  Future<String> encryptText() async {
    store = await Response.cipher(int.parse(cShift.text), cText.text);
    var result = store.result;
    return result;
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
                  controller: cShift,
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
                  controller: cText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Text'),
                ),
              ),
            ),
            Text(
              '$_text',
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(
              icon: Icon(Icons.architecture_outlined),
              iconSize: 48,
              onPressed: getText,
            ),
          ],
        ),
      ),
    );
  }
}
