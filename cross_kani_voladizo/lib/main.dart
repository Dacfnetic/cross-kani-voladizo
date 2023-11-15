import 'package:cross_kani_voladizo/barras_provider.dart';
import 'package:cross_kani_voladizo/objetos.dart';
import 'package:cross_kani_voladizo/propiedades_provider.dart';
import 'package:cross_kani_voladizo/puntos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget hola = const Text('Punto');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Row(children: [
        CrearYModificarObjetos(),
        Expanded(flex: 3, child: Placeholder()),
        Objetos(),
      ]),
    );
  }
}

class CrearYModificarObjetos extends ConsumerWidget {
  const CrearYModificarObjetos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget objeto = ref.watch(propiedadesProvider);
    List<Punto> puntos = ref.watch(puntosProvider);
    List<Barra> barras = ref.watch(barrasProvider);
    void aparecerPropiedades(value) {
      ref.read(propiedadesProvider.notifier).cambiarWidget(value);
    }

    return Expanded(
        flex: 1,
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: Colors.red),
            child: Column(
              children: [
                const Text('Agregar'),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5 / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          aparecerPropiedades(const CrearPunto());
                        },
                        child: const Text('Punto'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5 / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          aparecerPropiedades(const CrearBarra());
                        },
                        child: const Text('Barra'),
                      ),
                    ),
                  ],
                ),
                const Text('Propiedades'),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: objeto,
                ))
              ],
            )));
  }
}

class CrearPunto extends ConsumerWidget {
  const CrearPunto({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nombre = TextEditingController();
    TextEditingController cX = TextEditingController();
    TextEditingController cY = TextEditingController();
    return Form(
      child: ListView(children: [
        TextField(
          controller: nombre,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Nombre'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: cX,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Coordenada X'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: cY,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Coordenada Y'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(puntosProvider.notifier).agregarPunto(
                  nombre: nombre.text,
                  coordenadaX: double.parse(cX.text),
                  coordenadaY: double.parse(cY.text),
                );
            ref.read(propiedadesProvider.notifier).cambiarWidget(const SizedBox(
                  height: 5,
                ));
          },
          child: const Text('Crear'),
        ),
      ]),
    );
  }
}

class ModificarPunto extends ConsumerWidget {
  final Punto punto;
  const ModificarPunto({
    required this.punto,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nombre = TextEditingController();
    TextEditingController cX = TextEditingController();
    TextEditingController cY = TextEditingController();
    return Form(
      child: ListView(children: [
        TextField(
          controller: nombre,
          enabled: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(punto.nombre),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: cX,
          enabled: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(punto.coordenadaX.toString()),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: cY,
          enabled: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(punto.coordenadaY.toString()),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(puntosProvider.notifier).borrarPunto(punto.nombre);
            ref.read(propiedadesProvider.notifier).cambiarWidget(const SizedBox(
                  height: 5,
                ));
          },
          child: const Text('Borrar'),
        ),
      ]),
    );
  }
}

class CrearBarra extends StatelessWidget {
  const CrearBarra({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(children: [
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Punto inicial'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Punto final'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Área'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Inercia'),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Crear'),
        ),
      ]),
    );
  }
}

class Objetos extends ConsumerWidget {
  const Objetos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Punto> puntos = ref.watch(puntosProvider);
    List<Barra> barras = ref.watch(barrasProvider);
    return Expanded(
      flex: 1,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.yellow),
        child: Column(
          children: [
            const Text('Puntos'),
            Expanded(
              child: ListView(
                children: puntos,
              ),
            ),
            const Text('Barras'),
            Expanded(
              child: ListView(
                children: const [
                  Text('Barra'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
