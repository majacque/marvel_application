import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Heroes',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Marvel Heroes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _heroesList = [];

  Future<void> fetchHeroes() async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateMd5('$timeStamp$privateKey$publicKey');
    final response = await http.get(
      Uri.parse(
          'https://gateway.marvel.com/v1/public/characters?ts=$timeStamp&apikey=$publicKey&hash=$hash'),
    );
    if (response.statusCode == 200) {
      setState(() {
        final jsonData = json.decode(response.body);
        _heroesList = jsonData["data"]["results"];
      });
    } else {
      throw Exception('Failed to load heroes');
    }
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  void initState() {
    super.initState();
    fetchHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: _heroesList.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _heroesList.length,
                itemBuilder: (BuildContext context, int index) {
                  final hero = _heroesList[index];
                  return ListTile(
                    leading: Image.network(
                        '${hero["thumbnail"]["path"]}.${hero["thumbnail"]["extension"]}'),
                    title: Text(hero["name"]),
                    subtitle: Text(hero["description"]),
                  );
                },
              ),
      ),
    );
  }
}
