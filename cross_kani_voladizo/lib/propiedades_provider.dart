import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final propiedadesProvider =
    StateNotifierProvider<PropiedadesNotifier, Widget>((ref) {
  return PropiedadesNotifier();
});

class PropiedadesNotifier extends StateNotifier<Widget> {
  PropiedadesNotifier() : super(const SizedBox(height: 5));

  void cambiarWidget(index) {
    state = index;
  }
}
