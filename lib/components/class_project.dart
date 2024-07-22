


class Project {

   int id	;
  String nom;
  int createur_id ;
  int administrateur_id = -1;
  int projet_parent_id = -1;
  String description;
  double recette_actuelle	= 0;
  double depense_actuelle =	0;
  double budget = 0 ;
  String date_fin	;
  String image ;
  String created_at ;
  String updated_at	;

   Project(this.id,this.nom,this.createur_id,this.administrateur_id,this.projet_parent_id,
      this.description,this.recette_actuelle,this.depense_actuelle,this.budget,
      this.date_fin,this.image,this.created_at,this.updated_at);


   factory Project.fromMap(Map<dynamic,dynamic>map)=> Project(
       map["id"],map["nom"],map["createur_id"],map["administrateur_id"],map["projet_parent_id"],
       map["description"],map["recette_actuelle"],map["depense_actuelle"],map["budget"],
       map["date_fin"],map["image"],map["created_at"],map["updated_at"]);

}