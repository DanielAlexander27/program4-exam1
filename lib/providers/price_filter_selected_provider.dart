import 'package:flutter_3_riverpod_full/enum/price_filter_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceFilterSelectedProvider = StateProvider<PriceFilterEnum>((ref) {
  return PriceFilterEnum.todos;
});
