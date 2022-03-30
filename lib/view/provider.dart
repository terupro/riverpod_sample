import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//　Provider 定数

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  //　定義
  final _provider = Provider((ref) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, ref, child) => Text(
                '${ref.watch(_provider)}', //　表示
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
