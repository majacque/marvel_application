import 'package:flutter/material.dart';

class HeroDetailPage extends StatelessWidget {
  final Map<String, dynamic> hero;

  const HeroDetailPage({Key? key, required this.hero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hero["name"]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              '${hero["thumbnail"]["path"]}.${hero["thumbnail"]["extension"]}',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 16),
            Text(
              hero["name"],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  hero["description"].isNotEmpty
                      ? hero["description"]
                      : "No description available.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
