import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

const String url = "http://127.0.0.1:8000";
List<dynamic>  listProjectUser=[],listProjectAdminUser=[],listUnderProjects = [],listTransactionEffect=[],listTransactionGet=[],
                listCostsGet=[];
List<Map<String,dynamic>>listArticles=[];
List menuUserItems = [['Creer un projet','/createProject'],['Projets crées','/projectsCreates'],
                      ['Projets administres','/projects_administries'],['Supprimer un projet','/deleteProject']];
List menuProjectItems = [['Creer un sous-projet','/project/create_under_project'],['Sous-projets créés','/project/underProjectsCreate'],
                        ['Enregistrer une depense','/project/addSpend'],['Enregistrer transaction','/project/saveTransaction'],
                        ['Depenses Effectuées','/project/listCostsGet'],['Bilan du projet','/project/projectBalanceSheet']];

NumberFormat formatter = NumberFormat.decimalPatternDigits(
  locale: 'fr',
  decimalDigits: 2,
);

Map currentProject = {},currentUser = {};
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

  Future<List<Map>> getTransactions( int id) async {
    final uri = Uri.parse("$url/api/projet/$id/transactions");
    final response = await http.get(uri);
    final  Map<String, dynamic> A= json.decode(response.body) ;
    listTransactionEffect = A['transactions_effectuees'];
    listTransactionGet = A['transactions_recues'];
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