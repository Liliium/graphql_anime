import 'package:flutter/material.dart';

// Services
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Views
import 'package:graphql_consumer/views/home/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      title: 'GraphQL Consumer',
      home: const HomeView(),
    );
  }
}
