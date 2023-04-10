import 'package:flutter/material.dart';

import 'hero_detail_page.dart';

class HeroBox extends StatelessWidget {
  final dynamic hero;

  const HeroBox({
    Key? key,
    required this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HeroDetailPage(hero: hero),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 80,
                height: 80,
                child: ClipOval(
                  child: Image.network(
                    '${hero["thumbnail"]["path"]}.${hero["thumbnail"]["extension"]}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  hero["name"],
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
