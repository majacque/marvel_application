import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_application/hero_box.dart';
import 'dart:convert';
import 'api_key.dart';
import 'hero_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _heroesList = [];
  final client = http.Client();
  final int _limit = 20;
  int _offset = 0;
  bool _isLoading = false;

  Future<void> fetchHeroes() async {
    setState(() {
      _isLoading = true;
    });

    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateMd5('$timeStamp$privateKey$publicKey');
    final response = await client.get(
      Uri.parse(
          'https://gateway.marvel.com/v1/public/characters?ts=$timeStamp&apikey=$publicKey&hash=$hash&limit=$_limit&offset=$_offset'),
    );

    if (response.statusCode == 200) {
      setState(() {
        final jsonData = json.decode(response.body);
        final List<dynamic> heroes = jsonData["data"]["results"];

        if (_offset == 0) {
          _heroesList = heroes;
        } else {
          _heroesList.addAll(heroes);
        }

        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load heroes');
    }
  }

  Future<List<dynamic>> searchHeroes(String name) async {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateMd5('$ts$privateKey$publicKey');

    final url =
        'https://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash&nameStartsWith=$name';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Failed to search heroes');
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
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: HeroSearchDelegate(
                    heroesList: _heroesList,
                    searchHeroes: searchHeroes,
                  ),
                );
              }),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _offset += _limit;
            fetchHeroes();
            return true;
          }
          return false;
        },
        child: Center(
          child: _heroesList.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _heroesList.length + (_isLoading ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _heroesList.length && _isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      final hero = _heroesList[index];
                      return HeroBox(hero: hero);
                    }
                  },
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
}
