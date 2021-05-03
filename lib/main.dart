import 'package:flutter/material.dart';
import 'requests.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(MyApp());
}

enum choice { decrypt, encrypt }
choice? _selected = choice.decrypt;

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
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cShift = new TextEditingController();
  TextEditingController cText = new TextEditingController();

  String _text = 'Placeholder Text';

  void getText() async {
    print(_selected);
    switch (_selected) {
      case choice.decrypt:
        _text = await decryptText();
        setter();
        break;
      case choice.encrypt:
        _text = await encryptText();
        setter();
        break;
      default:
        setter();
    }
  }

  void setter() {
    setState(() {
      _text;
    });
  }

  List<bool> _selections = [true, false];

  Future<String> decryptText() async {
    Response store =
        await Response.decipher(int.parse(cShift.text), cText.text);
    var result = store.result;
    return result;
  }

  Future<String> encryptText() async {
    Response store = await Response.cipher(int.parse(cShift.text), cText.text);
    var result = store.result;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/img_1.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0.0, 0, 00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        RadioListTile<choice>(
                          title: const Text('Decrypt',
                              style: TextStyle(color: Colors.white)),
                          value: choice.decrypt,
                          groupValue: _selected,
                          onChanged: (choice? value) {
                            setState(() {
                              _selected = value;
                            });
                          },
                        ),
                        RadioListTile<choice>(
                          title: const Text('Encrypt',
                              style: TextStyle(color: Colors.white)),
                          value: choice.encrypt,
                          groupValue: _selected,
                          onChanged: (choice? value) {
                            setState(() {
                              _selected = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Text("CEASEAR CIPHER",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: TextField(
                  controller: cShift,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    // hintText: "gtwt23r",
                    // hintStyle: TextStyle(color: Colors.red),
                    labelText: "Cipher Key",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)),
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: TextField(
                  controller: cText,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    // hintText: "gtwt23r",
                    // hintStyle: TextStyle(color: Colors.red),
                    labelText: "Text",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)),
                    icon: Icon(
                      Icons.enhanced_encryption,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '$_text',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              IconButton(
                icon: Icon(Icons.architecture_outlined),
                color: Colors.white,
                iconSize: 48,
                onPressed: getText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
