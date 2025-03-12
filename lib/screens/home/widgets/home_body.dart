import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/enum/price_filter_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/cart_provider.dart';
import '../../../providers/price_filter_selected_provider.dart';
import '../../../providers/products_provider.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProducts = ref.watch(filteredProductsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);

    return Center(
      child: Column(
        children: [
          Text(
            'Selecciona una Opción:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          DropdownMenu<PriceFilterEnum>(
            initialSelection: ref.watch(priceFilterSelectedProvider),
            dropdownMenuEntries: PriceFilterEnum.values
                .map(
                  (priceFilter) => DropdownMenuEntry(
                      value: priceFilter, label: priceFilter.label),
                )
                .toList(),
            onSelected: (value) {
              if (value == null) return;

              ref
                  .read(priceFilterSelectedProvider.notifier)
                  .update((_) => value);
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.blueGrey.withAlpha((0.05 * 255).toInt()),
                    child: Column(
                      children: [
                        Image.asset(filteredProducts[index].image,
                            width: 60, height: 60),
                        Text(filteredProducts[index].title),
                        Text('USD ${filteredProducts[index].price}'),
                        if (cartProducts.contains(filteredProducts[index]))
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .removeProduct(filteredProducts[index]);
                            },
                            child: const Text('Eliminar'),
                          ),
                        if (!cartProducts.contains(filteredProducts[index]))
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .addProduct(filteredProducts[index]);
                            },
                            child: const Text('Agregar al carro'),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
