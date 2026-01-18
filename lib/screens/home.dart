import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:m_one/store/auth_store.dart';
import 'package:m_one/widgets/auth_background.dart';

import '../data/utils.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();

}


class _HomeState extends State<Home> {

  void onLogout() {
    authStore.logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    print({
      authStore.username,
      'user'
    });
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Color(0xFFCFE3FF),
       ),
       body: AuthBackground(child: SafeArea(child: Column(
         children: [
           CircleAvatar(
             minRadius: 36,
             child: Observer(builder: (_) {
                 return Text(
                     Utils.getFirstLetter(authStore.currentUser?.username ?? "X_DEBUG"),
                     style: TextStyle(
                       fontSize: 24
                     ),
                 );
             })
           ),
           SizedBox(height: 12),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Observer(builder: (_) => Text(authStore.currentUser?.email ?? "")),
               Observer(builder: (_) => Text(authStore.currentUser?.username ?? "")),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(
                   Icons.logout
               ),
               TextButton(onPressed: onLogout, child: Text("Logout"))
             ],
           )


         ],
       ))),
     );
  }
  
}