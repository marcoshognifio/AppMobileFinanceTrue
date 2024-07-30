
import 'package:flutter/material.dart';
import 'package:projet_memoire/user/login.dart';
import 'package:projet_memoire/user/inscription.dart';

class ConnectionPage extends StatefulWidget {
   const ConnectionPage({super.key});


  @override
  State<ConnectionPage> createState() => ConnectionPageState();
}

class ConnectionPageState extends State<ConnectionPage> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: TabBarView(
            children: [
              LoginPage(),
              InscriptionPage()
            ],
          ),
        ));
  }

}

