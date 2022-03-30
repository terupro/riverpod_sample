import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/view/future_provider.dart';
import 'package:riverpod_sample/view/provider.dart';
import 'package:riverpod_sample/view/state_notifier_provider.dart';
import 'package:riverpod_sample/view/state_provider.dart';
import 'package:riverpod_sample/view/stream_provider.dart';

// Providerの作成（ページを番号で管理する）
final page_state_provider = StateProvider((ref) => 0);

class Root extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerの監視
    final page_state = ref.watch(page_state_provider.notifier);

    // BottomNavigationBarの設計
    List<String> keys = ['P', 'SP', 'SNP', 'FP', 'SP'];
    List<Icon> icons = const [
      Icon(Icons.circle, color: Colors.white),
      Icon(Icons.circle, color: Colors.white),
      Icon(Icons.circle, color: Colors.white),
      Icon(Icons.circle, color: Colors.white),
      Icon(Icons.circle, color: Colors.white),
    ];
    List<Widget> pages = [
      const ProviderPage(
        title: 'Provider',
      ),
      const StateProviderPage(
        title: 'StateProvider',
      ),
      StateNotifierProviderPage(
        title: 'StateNotifierProvider',
      ),
      FutureProviderPage(
        title: 'FutureProviderPage',
      ),
      StreamProviderPage(
        title: 'StreamProviderPage',
      ),
    ];
    List<BottomNavigationBarItem> navi_items = [];
    for (int i = 0; i < keys.length; i++) {
      navi_items.add(BottomNavigationBarItem(icon: icons[i], label: keys[i]));
    }

    return Scaffold(
      body: pages[page_state.state],
      bottomNavigationBar: BottomNavigationBar(
        items: navi_items,
        currentIndex: ref.watch(page_state_provider),
        onTap: (index) {
          // ページ番号を切り替える
          page_state.state = index;
          print(page_state.state);
        },
      ),
    );
  }
}
