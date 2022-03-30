import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FutureProviderPage extends ConsumerWidget {
  FutureProviderPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const KEY = 'KEY';

  final _provider = FutureProvider<int>((ref) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY) ?? 0;
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
                    '${ref.watch(_provider).value}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => const Text('error'),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          int currentValue = prefs.getInt(KEY) ?? 0;
          prefs.setInt(KEY, currentValue + 1);
          ref.refresh(_provider);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
