import 'package:flutter/material.dart';
import 'package:true_finance/components/display_image.dart';
import 'package:true_finance/project/add_amount.dart';
import 'package:true_finance/project/add_article.dart';
import 'package:true_finance/project/add_depense.dart';
import 'package:true_finance/project/change_admin.dart';
import 'package:true_finance/project/create_project.dart';
import 'package:true_finance/project/delete_project.dart';
import 'package:true_finance/project/infos_project_new.dart';
import 'package:true_finance/project/list_costs.dart';
import 'package:true_finance/project/transaction_between_projects.dart';
import 'package:true_finance/project/transactions_do.dart';
import 'package:true_finance/project/transactions_get.dart';
import 'package:true_finance/user/change_profit_user.dart';
import 'package:true_finance/user/inscription.dart';
import 'package:true_finance/user/login.dart';
import 'package:true_finance/user/user_index.dart';
import 'package:true_finance/user/user_profit.dart';

void main() {
  runApp(const MyApp() );
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
        return MaterialPageRoute(builder: (context) => const LoginPage());//ConnectionPage() );//WelcomePage());

      case '/login':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const LoginPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/inscription':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const InscriptionPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/user/projects_create':

        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            ListProjectUser(choose:true),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/user/profit':

        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
                const UserProfit(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/user/change_profit':

        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> ChangeProfitUser(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/user/projects_admin':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            ListProjectUser(choose: false),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/create':

        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> AddProject(hasParent: false,),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/project/create_under_project':

        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> AddProject(hasParent: true),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/project/changeAdmin':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> const ChangeAdminProject(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
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

      case 'project/transactionGet':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>
            const ListTransactionsGet(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case 'project/transactionDo':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>
            const ListTransactionsDo(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/Info':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=>
            const InfoProjectNew(),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

      case '/project/addAmount':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const AddAmount(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/project/delete':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>
            const DeleteProject(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/displayImage':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondAnimation)=> DisplayImage(imageUrl: settings.arguments as String),
            transitionsBuilder:(context,animation,secondAnimation,child) {
              animation=CurvedAnimation(parent:animation, curve: Curves.ease);
              return FadeTransition(opacity: animation,child: child);
            });

    }
    return null;
  }
}
