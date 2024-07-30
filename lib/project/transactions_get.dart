import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/navbar_user.dart';
import 'package:projet_memoire/components/app_bar.dart';
import '../components/components.dart';

class ListTransactionsGet extends StatefulWidget {
  const ListTransactionsGet({super.key});

  @override
  State<ListTransactionsGet> createState() => ListTransactionsGetState();
}

class ListTransactionsGetState extends State<ListTransactionsGet> {


  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      bottomNavigationBar:const NavbarUser(),
      appBar:  const AppBarWidget( menu:'/menuProject' ),
      backgroundColor: Colors.white,
      body:FutureBuilder<List<dynamic>>(
          future: DataClass().getTransactionsGet(currentProject['id']),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>>snapshot){
            if(snapshot.hasData){

              return listTransactionsGet.isNotEmpty ? ListView.builder(
                  itemCount :listTransactionsGet.length ,
                  itemBuilder:(context, index){
                    return itemList( listTransactionsGet[index] as Map<String, dynamic>);
                  }) : emptyPage("Aucune transaction n'a été réçue  ",
                    Container());
            }
            else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }

  Widget itemList(Map<String,dynamic> item){

    return Padding(
      padding: const EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
      child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 8,
          color: const Color(0xfff8f8dd),
          child: Theme(
            data: ThemeData(

              splashColor: Colors.transparent,

              hoverColor: Colors.transparent,),
            child:ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              leading: SizedBox(width: 50, child: Image.asset('images/6.png',width: 100)),
              title:  Row(
                  children: [

                      Expanded(child: Text(item['objet'],
                          style:GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900))),
                      Padding(
                        padding: const EdgeInsets.only(right:  20.0),
                        child: Text(item['created_at'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: Color(
                            0xff838080))),
                      )
                  ]
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("${formatter.format(item['montant'])} FCFA",
                    style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
              ),
            ),
          )
      ),
    );
  }
}

