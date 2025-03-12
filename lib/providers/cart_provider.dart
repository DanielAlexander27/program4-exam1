import 'package:flutter_3_riverpod_full/models/product.dart';
import 'package:flutter_3_riverpod_full/providers/price_filter_selected_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enum/price_filter_enum.dart';

class CartNotifier extends Notifier<Set<Product>> {
  @override
  Set<Product> build() {
    return const {};
  }

  Set<Product> getItemsFilteredByPrice() {
    final priceFilterSelected = ref.read(priceFilterSelectedProvider);

    switch (priceFilterSelected) {
      case PriceFilterEnum.mas50USD:
        return state.where((e) => e.price >= 50.0).toSet();
      case PriceFilterEnum.menos50USD:
        return state.where((e) => e.price < 50.0).toSet();
      case PriceFilterEnum.todos:
        return state;
    }
  }

  // methods to update state
  void addProduct(Product product) {
    if (!state.contains(product)) {
      Set<Product> newState = {}; // Crear un nuevo conjunto vacío
      for (var p in state) {
        newState.add(p); // Agregar todos los productos actuales
      }
      newState.add(product); // Agregar el nuevo producto
      state = newState; // Asignar el nuevo conjunto al estado
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      Set<Product> newState = {};
      for (var p in state) {
        if (p.id != product.id) {
          newState.add(p);
        }
      }
      state = newState;
    }
  }

// Método para vaciar el carrito  (Challenge 1)
  void clearCart() {
    state = {};
  }

  // Getter para obtener el total del carrito
  int get cartTotal {
    int total = 0;

    for (Product product in getItemsFilteredByPrice()) {
      total += product.price;
    }
    return total;
  }
}

//Declaramos el riverpod de forma manual
//Note que se usa "NotifierProvider" (mutable)
final cartNotifierProvider =
    NotifierProvider<CartNotifier, Set<Product>>(CartNotifier.new);
