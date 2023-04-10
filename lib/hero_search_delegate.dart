import 'package:flutter/material.dart';
import 'hero_box.dart';
import 'hero_detail_page.dart';

class HeroSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> heroesList;
  final Future<List<dynamic>> Function(String) searchHeroes;

  HeroSearchDelegate({
    required this.heroesList,
    required this.searchHeroes,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = heroesList
        .where(
            (hero) => hero['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Si le terme de recherche ne se trouve pas dans la liste actuelle
    if (results.isEmpty) {
      // Faites appel à l'API Marvel
      return FutureBuilder<List<dynamic>>(
        future: searchHeroes(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final hero = results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HeroDetailPage(hero: hero),
                        ),
                      );
                    },
                    child: HeroBox(hero: hero),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    } else {
      // Sinon, afficher les résultats actuels
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final hero = results[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailPage(hero: hero),
                  ),
                );
              },
              child: HeroBox(hero: hero),
            ),
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
