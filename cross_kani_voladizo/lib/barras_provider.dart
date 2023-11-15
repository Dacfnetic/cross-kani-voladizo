import 'package:cross_kani_voladizo/objetos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final barrasProvider = StateNotifierProvider<BarraNotifier, List<Barra>>((ref) {
  return BarraNotifier();
});

class BarraNotifier extends StateNotifier<List<Barra>> {
  BarraNotifier() : super([]);

  void obtenerPropiedadesDeBarra(index) {}
}
