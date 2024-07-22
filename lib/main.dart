import 'package:flutter/material.dart';
import 'package:projet_memoire/project/add_article.dart';
import 'package:projet_memoire/project/add_depense.dart';
import 'package:projet_memoire/project/infos_project.dart';
import 'package:projet_memoire/project/list_costs.dart';
import 'package:projet_memoire/project/list_transaction.dart';
import 'package:projet_memoire/project/project_index.dart';
import 'package:projet_memoire/project/transaction_between_projects.dart';
import 'package:projet_memoire/user/connection.dart';
import 'package:projet_memoire/user/user_index.dart';

import 'components/data_class.dart';
import 'components/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Finance True App',
      onGenerateRoute:(settings)=>RouteGenerator.generatorRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
    );
  }
}

class RouteGenerator {
  static Route<dynamic> ?generatorRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const ConnectionPage() );//WelcomePage());

      case '/login':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const ConnectionPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/user/projects_create':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            ListProjectUser(listProjectsBuild: listProjectUser,),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/user/projects_admin':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            ListProjectUser(listProjectsBuild: [listProjectAdminUser]),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/addArticle':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const AddArticle(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/project/addSpend':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const AddSpent(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case  '/project/listCostsGet':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            const ListCosts(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/saveTransaction':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>
            const TransactionBetweenProjects(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/project/transactions':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>
            const ListTransaction(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/project/projectBalanceSheet':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            const ListTransaction(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/underProjects':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            const ListUnderProject(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/Info':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            const InfoProject(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/menuUser':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>
            Drawer(child:MenuWidget(menu:menuUserItems),),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(-1, 0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/menuProject':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>Drawer(child:MenuWidget(menu:menuProjectItems)),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(-1, 0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });
    }
    return null;
  }
}
