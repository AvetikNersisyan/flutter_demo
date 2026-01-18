import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import './store/counter_store.dart';
import './screens/auth.dart';

final storeCounter = CounterStore();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth',
      routes: {
        '/auth': (_) => const AuthScreen(),
        // '/': (_) => const MyHomePage(title: 'Flutter Demo Home Page'),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) =>  Scaffold(
          body: Center(
            child: Text('No route'),
          ),
        ));
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
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

  void _incrementCounter() {
    storeCounter.increment();

  }

  void onAuthPage() {
      Navigator.pushReplacementNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Observer(builder: (ctx)  {
                return Text('${storeCounter.count}', style: Theme.of(ctx).textTheme.headlineLarge);
            }),
            FilledButton(onPressed: onAuthPage, child: const Text("Auth page"))
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
