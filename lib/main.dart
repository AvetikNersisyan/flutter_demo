import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:m_one/screens/home.dart';
import 'package:m_one/store/auth_store.dart';
import './screens/auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check for current sessionn.
  await authStore.checkSession();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // check if user is logged in. if not navigate to auth page ( screen)
    final initialRoute = authStore.currentUser != null ? '/' : '/auth';
    
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/auth': (_) => const AuthScreen(),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) =>  Scaffold(
          body: Center(
            child: Text('No route'),
          ),
        ));
      },
      title: 'M One',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      home: const Home(),
    );
  }
}

