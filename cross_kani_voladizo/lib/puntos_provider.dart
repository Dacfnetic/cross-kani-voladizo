import 'package:cross_kani_voladizo/objetos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puntosProvider = StateNotifierProvider<Notifier, List<Punto>>((ref) {
  return Notifier();
});

class Notifier extends StateNotifier<List<Punto>> {
  Notifier() : super([]);

  Punto obtenerPropiedadesDePunto(value) {
    List<Punto> valor =
        state.where((element) => element.nombre == value).toList();
    return valor[0];
  }

  void agregarPunto({
    nombre = String,
    coordenadaX = double,
    coordenadaY = double,
  }) {
    state = [
      ...state,
      Punto(
        nombre: nombre,
        coordenadaX: coordenadaX,
        coordenadaY: coordenadaY,
      )
    ];
  }

  void borrarPunto(value) {
    List<Punto> nuevosPuntos =
        state.where((element) => element.nombre != value).toList();
    state = nuevosPuntos;
  }
}
