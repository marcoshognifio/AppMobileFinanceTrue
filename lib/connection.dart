
import 'package:flutter/material.dart';
import 'package:projet_memoire/login.dart';
import 'package:projet_memoire/inscription.dart';


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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20),),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.blueAccent
                  ) ,
                  child:  const TabBar(
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 3,color: Colors.white),),
                    ),

                    tabs: [
                      TabItem(title: 'Connexion'),
                      TabItem(title: 'Inscription')
                    ],
                  ),
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: const TabBarView(
            children: [
              LoginPage(),
              InscriptionPage()
            ],
          ),
        ));
  }

}


class TabItem extends StatelessWidget{
  final String title;


  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
            style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

}