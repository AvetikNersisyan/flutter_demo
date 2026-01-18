import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:m_one/screens/home.dart';
import 'package:m_one/store/auth_store.dart';
import './screens/auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check for curr session
  await authStore.checkSession();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Determine initial route based on session
    final initialRoute = authStore.currentUser != null ? '/' : '/auth';
    
    return MaterialApp(
      initialRoute: initialRoute,
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
      home: const Home(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     super.initState();
//     // Check authentication when home page loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (authStore.currentUser == null) {
//         Navigator.pushReplacementNamed(context, '/auth');
//       }
//     });
//   }
//
//   void _incrementCounter() {
//     storeCounter.increment();
//
//   }
//
//
//   void onLogout() async {
//     await authStore.logout();
//     if (mounted) {
//       Navigator.pushReplacementNamed(context, '/auth');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         actions: [
//           Observer(
//             builder: (_) {
//               if (authStore.currentUser != null) {
//                 return Row(
//                   children: [
//                     Text(
//                       'Welcome, ${authStore.currentUser!.username}',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(width: 8),
//                     IconButton(
//                       icon: const Icon(Icons.logout),
//                       onPressed: onLogout,
//                       tooltip: 'Logout',
//                     ),
//                   ],
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Observer(builder: (ctx)  {
//                 return Text('${storeCounter.count}', style: Theme.of(ctx).textTheme.headlineLarge);
//             }),
//           ],
//         ),
//       ),
//         floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
