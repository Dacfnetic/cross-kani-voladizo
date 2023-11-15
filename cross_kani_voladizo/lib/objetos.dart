import 'package:cross_kani_voladizo/barras_provider.dart';
import 'package:cross_kani_voladizo/main.dart';
import 'package:cross_kani_voladizo/propiedades_provider.dart';
import 'package:cross_kani_voladizo/puntos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Punto extends ConsumerWidget {
  String nombre;
  double coordenadaX;
  double coordenadaY;
  List<Fuerza>? fuerzas;
  List<Barra>? barras;

  Punto({
    Key? key,
    required this.nombre,
    required this.coordenadaX,
    required this.coordenadaY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget objeto = ref.watch(propiedadesProvider);
    List<Punto> puntos = ref.watch(puntosProvider);
    List<Barra> barras = ref.watch(barrasProvider);

    void aparecerPropiedades(value) {
      ref.read(propiedadesProvider.notifier).cambiarWidget(value);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          aparecerPropiedades(
            ModificarPunto(
              punto: ref
                  .read(puntosProvider.notifier)
                  .obtenerPropiedadesDePunto(nombre),
            ),
          );
        },
        child: Text(nombre),
      ),
    );
  }
}

class Fuerza {
  Fuerza({
    magnitud = double,
    direccion = double,
  });
}

class Barra {
  Barra({
    distancia = double,
    area = double,
    inercia = double,
  });
}
