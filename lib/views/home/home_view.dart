import 'package:flutter/material.dart';

// Services
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Model
import 'package:graphql_consumer/models/home_modeel.dart';

// Widgets
import 'package:graphql_consumer/views/home/widgets/anime_list.dart';

final homeModelProvider = ChangeNotifierProvider((ref) => HomeModel());

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeModelProvider);

    useEffect((() {
      model.getData().then((_) => model.update(modelReady: true));
      return null;
    }), []);

    ref.listen(homeModelProvider, (HomeModel? prev, HomeModel? next) {
      if (model.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(model.uiMessage)));
        model.update(uiMessage: '', error: false);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Anime List')),
      body: model.modelReady ? AnimeList(model: model) : const Center(child: CircularProgressIndicator()),
    );
  }
}
