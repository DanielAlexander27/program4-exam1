import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/providers/display_all_data_provider.dart';
import 'package:flutter_3_riverpod_full/shared/cart_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/home_body.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayData = ref.watch(displayAllDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos en Venta'),
        actions: [
          Switch(
            value: displayData,
            onChanged: (value) =>
                ref.read(displayAllDataProvider.notifier).update((_) => value),
          ),
          CartIcon(
            active: displayData,
          ),
        ],
      ),
      body: displayData ? HomeBody() : SizedBox.shrink(),
    );
  }
}
