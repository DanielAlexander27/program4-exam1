import 'package:flutter_3_riverpod_full/enum/price_filter_enum.dart';
import 'package:flutter_3_riverpod_full/models/product.dart';
import 'package:flutter_3_riverpod_full/providers/price_filter_selected_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<Product> allProducts = [
  Product(
      id: '1',
      title: 'Shorts con Estilo',
      price: 12,
      image: 'assets/products/shorts.png'),
  Product(
      id: '2',
      title: 'Kit de karate',
      price: 34,
      image: 'assets/products/karati.png'),
  Product(
      id: '3',
      title: 'Jeans de Mezclilla',
      price: 54,
      image: 'assets/products/jeans.png'),
  Product(
      id: '4',
      title: 'Mochila Roja',
      price: 14,
      image: 'assets/products/backpack.png'),
  Product(
      id: '5',
      title: 'Tambor y Baquetas',
      price: 29,
      image: 'assets/products/drum.png'),
  Product(
      id: '6',
      title: 'Maleta Azul',
      price: 44,
      image: 'assets/products/suitcase.png'),
  Product(
      id: '7',
      title: 'Patines de Ruedas',
      price: 52,
      image: 'assets/products/skates.png'),
  Product(
      id: '8',
      title: 'Guitarra Eléctrica',
      price: 79,
      image: 'assets/products/guitar.png'),
];

//Definimos riverpod provider de forma manual
final productsProvider = Provider<List<Product>>((ref) {
  // Provider (No mutable)
  return allProducts;
});

//Provider (no mutable) riverpod reducido con productos menores de 50
final reducedProductsProvider = Provider<List<Product>>((ref) {
  return allProducts.where((p) => p.price < 50).toList();
});

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final allProducts = ref.watch(productsProvider);
  final priceFilterSelected = ref.watch(priceFilterSelectedProvider);

  switch (priceFilterSelected) {
    case PriceFilterEnum.mas50USD:
      return allProducts.where((e) => e.price >= 50.0).toList();
    case PriceFilterEnum.menos50USD:
      return allProducts.where((e) => e.price < 50.0).toList();
    case PriceFilterEnum.todos:
      return allProducts;
  }
});
