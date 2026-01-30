import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[700]!),
        useMaterial3: true,
      ),
      home: MyListScreenWithController(),
    );
  }
}

class MyListScreen extends StatelessWidget {
  MyListScreen({super.key});

  final List<String> items =
      List.generate(200, (i) => 'Item number $i'); // lista grande de ejemplo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista con PageStorageKey")),
      body: ListView.builder(
        key: const PageStorageKey('myListScrollKey'),
        // 👆 Muy importante: con esta clave Flutter recordará la posición
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DetailScreen()),
              );
            },
          );
        },
      ),
    );
  }
}

// class DetailScreen extends StatelessWidget {
//   const DetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Detalle")),
//       body: const Center(child: Text("Pantalla de detalle")),
//     );
//   }
// }

class MyListScreenWithController extends StatefulWidget {
  const MyListScreenWithController({super.key});

  @override
  State<MyListScreenWithController> createState() =>
      _MyListScreenWithControllerState();
}

class _MyListScreenWithControllerState
    extends State<MyListScreenWithController> {
  late ScrollController scrollController;
  double savedPosition = 0.0; // 👈 aquí guardaremos la posición

  final List<String> items = List.generate(200, (i) => 'Item number $i');

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    // 👇 Guardamos la posición cada vez que el usuario se mueve
    scrollController.addListener(() {
      savedPosition = scrollController.position.pixels;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 👇 Restauramos la posición cuando volvemos a esta pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (savedPosition > 0) {
        scrollController.jumpTo(savedPosition);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista con ScrollController")),
      body: ListView.builder(
        controller: scrollController, // 👈 aplicamos el controller
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DetailScreen()),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle")),
      body: const Center(child: Text("Pantalla de detalle")),
    );
  }
}
