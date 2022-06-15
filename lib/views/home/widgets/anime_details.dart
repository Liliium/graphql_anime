import 'package:flutter/material.dart';
import 'package:graphql_consumer/models/home_modeel.dart';

class AnimeDetails extends StatelessWidget {
  const AnimeDetails({Key? key, required this.anime}) : super(key: key);
  final Anime anime;

  @override
  Widget build(BuildContext context) {
    final secondaryText = TextStyle(fontSize: 14, color: Colors.grey.shade600);

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(anime.name.english ?? '~', textAlign: TextAlign.left),
            Text(anime.name.kanji ?? '~', textAlign: TextAlign.left),
            const Divider(),
            Text('Status: ${anime.status}', textAlign: TextAlign.left, style: secondaryText),
            const SizedBox(height: 5),
            Text('Episodes: ${anime.episodes}', textAlign: TextAlign.left, style: secondaryText),
            const SizedBox(height: 5),
            Text(anime.dateAsString, textAlign: TextAlign.left, style: secondaryText),
            const Divider(),
            Column(
              children: anime.characters.map((character) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(character.picture ?? '', fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(child: Text(character.name ?? '~')),
                  ]),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
