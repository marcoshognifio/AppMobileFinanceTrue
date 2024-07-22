import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

const String url = "http://127.0.0.1:8000";
List<dynamic>  listProjectUser=[],listProjectAdminUser=[],listUnderProjects = [],
        listTransactionsDo=[],listTransactionsGet=[],listTransactionsAmountGet=[],listCostsGet=[];
List<Map<String,dynamic>>listArticles=[];

NumberFormat formatter = NumberFormat.decimalPatternDigits(
  locale: 'fr',
  decimalDigits: 2,
);

Map currentProject = {},currentUser = {};

List menuUserItems = [['Creer un projet','/createProject'],
                      ['Projets crées','/projectsCreates'],
                      ['Projets administres','/projects_administries'],
                      ['Transactions Récues','project/transactionGet']
                      ];

List menuProjectItems = [['Creer un sous-projet','/project/create_under_project'],
                          ['Enregistrer transaction','/project/saveTransaction'],
                          ['Enregistrer une depense','/project/addSpend'],
                          ['Transactions Récues','project/transactionGet'],
                          ['Transactions Effectuées','project/transactionDo'],
                          ['Depenses Effectuées','/project/listCostsGet'],
                          ['Bilan du projet','/project/projectBalanceSheet']
                        ];


List<Function()> listActions =[

  ()async{

  },
  ()async{

  },

  ()async{
    await DataClass().getTransactionsGet(currentProject['id']);
  },

  ()async{
    await DataClass().getTransactionsDo(currentProject['id']);
  },

  ()async{
  await DataClass().getCosts(currentProject['id']);
  }
];

class DataClass {

  Future<List<Map>> getProjectsUser( int id) async {

    final uri = Uri.parse("$url/api/user/$id/projets");
    final response = await http.get(uri);
    final  Map<String, dynamic> A= json.decode(response.body);

    listProjectUser = A['projets_crees'] ;
    listProjectAdminUser = A['projets_administres'];
    return [];
  }

  Future<List<Map>> getUnderProjects( int id) async {

    final uri = Uri.parse("$url/api/projet/$id/sous_projets");
    final response = await http.get(uri);
    listUnderProjects = json.decode(response.body) ;
    return [];
  }

  Future<List<Map>> getTransactionsDo( int id) async {
    final uri = Uri.parse("$url/api/projet/$id/transactions_effectuees");
    final response = await http.get(uri);
    final  Map<String, dynamic> A= json.decode(response.body) ;
    listTransactionsDo = A['transactions_effectuees'];
    listTransactionsAmountGet = A['montants_transactions'];
    return [];
  }

  Future<List<Map>> getTransactionsGet( int id) async {
    final uri = Uri.parse("$url/api/projet/$id/transactions_recues");
    final response = await http.get(uri);
    listTransactionsGet = json.decode(response.body);
    return [];
  }

  Future<List<Map>> getCosts( int id) async {
    final uri = Uri.parse("$url/api/projet/$id/depense/index");
    final response = await http.get(uri);
    listCostsGet = json.decode(response.body);
    return [];
  }


  List<Map<String,dynamic>> getItemsUnderProjects(){

    List<Map<String,dynamic>> result = [];
    for(int i=0,c=listUnderProjects.length;i<c;i++){
      result.add( {"value" : listUnderProjects[i]["id"],"label" :listUnderProjects[i]["nom"]});
    }
    if(currentProject['projet_parent_id'] !=null){
      result.add( {"value" : currentProject['projet_parent_id'],"label" :"Le Projet Parent"});
    }
    return result;
  }



}