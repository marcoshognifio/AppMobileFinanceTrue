import 'package:flutter/material.dart';
//import 'package:projet_memoire/user/login.dart';
//import 'package:projet_memoire/user/inscription.dart';
import 'package:projet_memoire/user/login_new.dart';
import 'package:projet_memoire/user/inscription_new.dart';

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


class TabItem extends StatelessWidget {
  final String title;


  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

