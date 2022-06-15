import 'package:flutter/material.dart';

// Model
import 'package:graphql_consumer/models/home_modeel.dart';

// Widgets
import 'package:graphql_consumer/widgets/column_builder.dart';
import 'package:graphql_consumer/views/home/widgets/anime_details.dart';

class AnimeList extends StatelessWidget {
  const AnimeList({Key? key, required this.model}) : super(key: key);
  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ColumnBuilder(
          itemCount: 10,
          topWidget: Row(children: [
            IconButton(onPressed: () => model.prevPage(), icon: const Icon(Icons.arrow_back)),
            Expanded(child: Text(model.currentPage.toString(), textAlign: TextAlign.center)),
            IconButton(onPressed: () => model.nextPage(), icon: const Icon(Icons.arrow_forward)),
          ]),
          itemBuilder: (context, index) {
            final anime = model.animeList[index];

            return GestureDetector(
              onTap: () => showDialog(context: context, builder: (context) => AnimeDetails(anime: anime)),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(anime.name.english ?? '~', textAlign: TextAlign.left),
                        Text(anime.name.kanji ?? '~', textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
