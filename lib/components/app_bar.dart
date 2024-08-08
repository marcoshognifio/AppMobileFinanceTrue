import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/components/data_class.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String menu;


  const AppBarWidget({super.key,  required this.menu});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Color(0xff363636),
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Center(child: Text('True Finance App',
                style: GoogleFonts.lato(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 17,fontWeight: FontWeight.w900))),

          leading:IconButton(
              icon: const  Icon(Icons.arrow_back_sharp,size: 40,color: Colors.white,),
              onPressed: () async{
                String a= listRoutes.last;
                if( a == '/project/Info'){
                  currentProject = listCurrentProjects.last;
                  listCurrentProjects.removeLast();
                }
                listRoutes.removeLast();
                if(listRoutes.isNotEmpty){
                  String a = listRoutes.last;

                  Navigator.pushNamed (context,a);
                }
                else{

                  await showDialog(
                    context: context,
                    builder: (context) =>AlertDialog(
                      title: const Text("Voulez vous quittez l'application ?"),
                      actions: [

                        TextButton(onPressed:() async{
                            Navigator.of(context).pop();
                        }, child: const Text("Retourner")),

                        TextButton(onPressed:()async {
                          SystemNavigator.pop();
                        }, child: const Text("Quitter"))
                      ],
                    )
                  );

                }
              },
          ) ,
          actions: [
            IconButton(
              icon: currentUser['image'] != null ? Image.network(currentUser['image'],width: 40,height: 40,):const Icon(Icons.account_circle_rounded,color: Colors.white,size: 40,),
              onPressed: (){
                listRoutes.add('/user/profit');
                Navigator.pushNamed(context,'/user/profit');
              }
            )
          ],
        ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}