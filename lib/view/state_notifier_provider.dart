import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// クラスの作成
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void countUp() {
    state++;
  }
}

class StateNotifierProviderPage extends ConsumerWidget {
  StateNotifierProviderPage({Key? key, required this.title}) : super(key: key);
  final String title;

  // 定義
  final _stateNotifierProvider =
      StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

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
            Text(
              '${ref.watch(_stateNotifierProvider)}', // 表示
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.watch(_stateNotifierProvider.notifier).countUp(), //　変更
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
