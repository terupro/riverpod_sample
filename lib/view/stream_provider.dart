import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

StreamController<int> streamController = StreamController();

class StreamProviderPage extends ConsumerWidget {
  StreamProviderPage({Key? key, required this.title}) : super(key: key);
  final String title;
  int _counter = 0;

  // 定義
  final _provider = StreamProvider<int>((ref) {
    if (streamController.hasListener) {
      streamController = StreamController();
    }
    return streamController.stream;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch(_provider).when(
                  data: (data) => Text(
                    '${ref.watch(_provider).value}', // 表示
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => const Text('error'),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter++;
          streamController.sink.add(_counter); // 変更
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
