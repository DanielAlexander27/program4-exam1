import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/providers/cart_provider.dart';
import 'package:flutter_3_riverpod_full/providers/products_provider.dart';
import 'package:flutter_3_riverpod_full/screens/cart/cart_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartIcon extends ConsumerWidget {
  final bool active;

  const CartIcon({super.key, required this.active});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartNotifierProvider);
    ref.watch(filteredProductsProvider);
    final numeroItems = ref
        .watch(cartNotifierProvider.notifier)
        .getItemsFilteredByPrice()
        .length;

    return Stack(
      children: [
        IconButton(
          onPressed: active
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  )
              : null,
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent,
            ),
            child: Text(
              active ? numeroItems.toString() : '',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
