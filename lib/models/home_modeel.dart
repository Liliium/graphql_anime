import 'dart:convert';

import 'package:graphql_consumer/models/graphal_query.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AnimeCharacter {
  AnimeCharacter(this.name, this.picture);
  final String? name, picture;

  factory AnimeCharacter.fromJson(dynamic json) {
    return AnimeCharacter(json['name']['userPreferred'], json['image']['large']);
  }
}

class AnimeName {
  AnimeName(this.english, this.kanji);
  final String? english, kanji;

  factory AnimeName.fromJson(dynamic json) {
    return AnimeName(json['title']['english'], json['title']['native']);
  }
}

class Anime {
  Anime({
    required this.name,
    required this.status,
    required this.episodes,
    required this.characters,
    required this.startDate,
    required this.endDate,
  });

  final List<AnimeCharacter> characters;
  final DateTime startDate, endDate;
  final AnimeName name;
  final String? status;
  final int? episodes;

  String get dateAsString => '$startDateFormatted - $endDateFormatted';

  String get startDateFormatted => '${startDate.year}/${startDate.month}';
  String get endDateFormatted => '${endDate.year}/${endDate.month}';

  factory Anime.fromJson(dynamic json) {
    final characters = json['characters']['nodes'] as List;

    return Anime(
      name: AnimeName.fromJson(json),
      status: json['status'],
      episodes: json['episodes'],
      characters: characters.map((e) => AnimeCharacter.fromJson(e)).toList(),
      startDate: DateTime(json['startDate']['year'] ?? DateTime.now().year, json['startDate']['month'] ?? DateTime.now().month),
      endDate: DateTime(json['endDate']['year'] ?? DateTime.now().year, json['endDate']['month'] ?? DateTime.now().month),
    );
  }
}

class HomeModel extends ChangeNotifier {
  HomeModel() {
    resetModel();
  }

  late List<Anime> animeList;
  late String uiMessage;
  late bool loading, error;
  late bool modelReady;
  late int currentPage;

  Future<void> getData() async {
    if (loading) return;
    update(silent: !modelReady, loading: true);
    final url = Uri.parse('https://graphql.anilist.co/');
    final response = await http.post(url, body: {'query': GraphQuery(currentPage).query});
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final objs = json['data']['Page']['media'] as List;

    animeList.clear();
    objs.forEach(_addAnime);
    update(loading: false);
  }

  void _addAnime(dynamic data) {
    animeList.add(Anime.fromJson(data));
  }

  void prevPage() {
    if (currentPage <= 1) return;
    update(currentPage: currentPage - 1);
    getData();
  }

  void nextPage() {
    // TODO: logic to handle running out of pages
    update(currentPage: currentPage + 1);
    getData();
  }

  void resetModel() {
    currentPage = 1;
    modelReady = false;
    loading = false;
    error = false;
    uiMessage = '';
    animeList = List.empty(growable: true);
  }

  void update({
    bool silent = false,
    String? uiMessage,
    bool? modelReady,
    bool? loading,
    bool? error,
    int? currentPage,
  }) {
    this.currentPage = currentPage ?? this.currentPage;
    this.modelReady = modelReady ?? this.modelReady;
    this.uiMessage = uiMessage ?? this.uiMessage;
    this.loading = loading ?? this.loading;
    this.error = error ?? this.error;

    silent ? null : notifyListeners();
  }

  bool get loadingAnimation => !modelReady || loading;
}
