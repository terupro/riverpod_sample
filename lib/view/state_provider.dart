import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider 変数

class StateProviderPage extends StatefulWidget {
  const StateProviderPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<StateProviderPage> createState() => _StateProviderPageState();
}

class _StateProviderPageState extends State<StateProviderPage> {
  // 定義
  final _stateProvider = StateProvider((ref) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) => Text(
                '${ref.watch(_stateProvider)}', // 表示
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          onPressed: () {
            ref.read(_stateProvider.notifier).state =
                ref.read(_stateProvider) + 1; //変更(種類は豊富にある)
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
