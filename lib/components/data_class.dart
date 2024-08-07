import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

const String url = "http://127.0.0.1:8000";

String token="";

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

List<dynamic>  listProjectUser=[],listProjectAdminUser=[],listUnderProjects = [],
        listTransactionsDo=[],listTransactionsGet=[],listTransactionsDoAmount=[],listCostsGet=[];
List<Map<String,dynamic>>listArticles=[];

NumberFormat formatter = NumberFormat.decimalPatternDigits(
  locale: 'fr',
  decimalDigits: 2,
);

Map currentProject = {},currentUser = {};

List<String> listRoutes = [];
List<Map> listCurrentProjects = [];

List menuUserItems = [['Creer un projet','/project/create'],
                      ['Ajouter de fond','/project/addAmount'],
                      //['Changer d\'administrateur','/project/changeAdmin'],
                      ['Supprimer un projet','/project/delete'],
                      ];

List menuAdminProjectItems = [['Creer un sous-projet','/project/create_under_project'],
                          ['Enregistrer transaction','/project/saveTransaction'],
                          ['Enregistrer une depense','/project/addSpend'],
                          ['Transactions Récues','project/transactionGet'],
                          ['Transactions Effectuées','project/transactionDo'],
                          ['Depenses Effectuées','/project/listCostsGet'],
                        ];

List menuCreatorProjectItems = [['Transactions Récues','project/transactionGet'],
                                ['Transactions Effectuées','project/transactionDo'],
                                ['Depenses Effectuées','/project/listCostsGet'],
                              ];


class DataClass {

  Future<List<Map>> getProjectsAdminUser(int id) async {

    final uri = Uri.parse("$url/api/user/$id/projets_admin");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    listProjectAdminUser = json.decode(response.body);
    return [];

  }

  Future<List<Map>> getProjectsCreateUser(int id) async {
    final uri = Uri.parse("$url/api/user/$id/projets_create");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    listProjectUser = json.decode(response.body);
    return [];
  }

  Future<List<Map>> getUnderProjects(int id) async {
    final uri = Uri.parse("$url/api/projet/$id/sous_projets");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    listUnderProjects = json.decode(response.body);
    return [];
  }

  Future<List<Map>> getTransactionsDo(int id) async {
    final uri = Uri.parse("$url/api/projet/$id/transactions_effectuees");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    final Map<String, dynamic> A = json.decode(response.body);
    listTransactionsDo = A['transactions_effectuees'];
    listTransactionsDoAmount = A['montants_transactions'];
    return [];
  }

  Future<List<Map>> getTransactionsGet(int id) async {
    final uri = Uri.parse("$url/api/projet/$id/transactions_recues");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    listTransactionsGet = json.decode(response.body);
    return [];
  }

  Future<List<Map>> getCosts(int id) async {
    final uri = Uri.parse("$url/api/projet/$id/depense/index");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    listCostsGet = json.decode(response.body);
    return [];
  }

  List<Map<String, dynamic>> getItemsProjectsUser() {
    List<Map<String, dynamic>> result = [];
    for (int i = 0, c = listProjectUser.length; i < c; i++) {
      result.add({
        "value": listProjectUser[i]["id"],
        "label": listProjectUser[i]["nom"]
      });
    }
    return result;
  }

  List<Map<String, dynamic>> getItemsUnderProjects() {
    List<Map<String, dynamic>> result = [];
    for (int i = 0, c = listUnderProjects.length; i < c; i++) {
      result.add({
        "value": listUnderProjects[i]["id"],
        "label": listUnderProjects[i]["nom"]
      });
    }
    if (currentProject['projet_parent_id'] != null) {
      result.add({
        "value": currentProject['projet_parent_id'],
        "label": "Le Projet Parent"
      });
    }
    return result;
  }

  List<Map<String, dynamic>> getItemsProjectsCreate() {
    List<Map<String, dynamic>> result = [];
    for (int i = 0, c = listProjectUser.length; i < c; i++) {
      result.add({
        "value": listProjectUser[i]["id"],
        "label": listProjectUser[i]["nom"]
      });
    }
    return result;
  }

}
