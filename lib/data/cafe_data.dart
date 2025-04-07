import 'package:kafecraft_exam/model/cafe_type.dart';
import 'package:kafecraft_exam/model/gato.dart';

final cafeTypes = [
  CafeType(
    name: 'Rubisca',
    avatar: '🌱',
    growTime: const Duration(minutes: 1),
    costDeeVee: 2,
    fruitWeight: 0.632,
    gato: Gato(gout: 15, amertume: 54, teneur: 35, odorat: 19),
  ),
  CafeType(
    name: 'Arbrista',
    avatar: '🌳',
    growTime: const Duration(minutes: 4),
    costDeeVee: 6,
    fruitWeight: 0.274,
    gato: Gato(gout: 87, amertume: 4, teneur: 35, odorat: 59),
  ),
  CafeType(
    name: 'Roupetta',
    avatar: '🍒',
    growTime: const Duration(minutes: 2),
    costDeeVee: 3,
    fruitWeight: 0.461,
    gato: Gato(gout: 35, amertume: 41, teneur: 75, odorat: 67),
  ),
  CafeType(
    name: 'Tourista',
    avatar: '🌿',
    growTime: const Duration(minutes: 1),
    costDeeVee: 1,
    fruitWeight: 0.961,
    gato: Gato(gout: 3, amertume: 91, teneur: 74, odorat: 6),
  ),
  CafeType(
    name: 'Goldoria',
    avatar: '✨',
    growTime: const Duration(minutes: 3),
    costDeeVee: 2,
    fruitWeight: 0.473,
    gato: Gato(gout: 39, amertume: 9, teneur: 7, odorat: 87),
  ),
];
