import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = "http://127.0.0.1:8000";
List<Map<String,dynamic>> listTransaction=[],numBuy=[],listSale=[];
List<dynamic>  listProjectUser=[],listUnderProjects = [];
List menuUserItems = [['Creer un projet','/create_project'],['Projets crées','/projects_creates'],
                      ['Projets administres','/projects_administries'],['Supprimer un projet','/delete_project']];
List menuProjectItems = [['Creer un sous-projet','/project/create_under_project'],['Sous-projets créés','/project/under_projects_create'],
                        ['Enregistrer une depense','/project/save_spend'],['Enregistrer transaction','/project/save_transaction'],
                        ['Bilan du projet','/project/project_balance_sheet']];



Map currentProject = {},currentUser = {};
class DataClass {

  Future<List<Map>> getProjectsUser( int id) async {

    final uri = Uri.parse("${url}/api/user/$id/projets");
    final response = await http.get(uri);
    listProjectUser = json.decode(response.body)["data"] ;

    return [];
  }

  Future<List<Map>> getUnderProjects( int id) async {

    final uri = Uri.parse("${url}/api/user/projet/$id/sous_projets");
    final response = await http.get(uri);
    listUnderProjects = json.decode(response.body)["data"] ;

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