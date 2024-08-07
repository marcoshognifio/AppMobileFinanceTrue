import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/components/button.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/navbar_user.dart';

class  UserProfit extends StatefulWidget {
  const UserProfit({super.key});

  @override
  State<UserProfit> createState() => _UserProfitState();
}

class _UserProfitState extends State<UserProfit> {


  late Map  project;
  TextStyle titleUpStyle = GoogleFonts.lato(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900);
  TextStyle titleStyle = GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900);
  TextStyle titleLowerStyle = const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15);

  actionFunction() async {

    currentProject = project;
    await DataClass().getUnderProjects(currentProject['id']);
    Navigator.pushNamed(context,'/project/Info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavbarUser(),
        appBar:  const AppBarWidget( menu:'/menuProject' ),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Card(
                shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Colors.blueAccent,
                        width: 1
                    )
                ),
                margin: const EdgeInsets.only(top: 50,bottom: 50,left: 20,right: 20),
                elevation: 5,
                color: const Color(0xfff8f8dd),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              padding:const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color:Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft:Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),
                              ),
                              child: Text('Votre Profit',style: titleUpStyle)
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,bottom: 20,right: 10,left: 10),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(left: 20,right: 20),
                              padding: const EdgeInsets.only(top: 10),
                              height: 150,
                              width: 150,
                              child: IconButton(icon: Image.asset('images/6.png',width: 150,height: 150,),

                                onPressed: () {
                                  listRoutes.add('/user/change_profit');
                                  Navigator.pushNamed(context, '/user/change_profit');
                                },)
                            ),
                          ),
                          containing('Nom :',"${currentUser['name']}" ),
                          containing('Telephone :',"${currentUser['telephone']}"),
                          containing('Email :',"${currentUser['email']}" ),
                          containing('Projets créés en cours :',"${listProjectUser.length}" ),
                          containing('Projets administrés en cours :',"${listProjectAdminUser.length}" )

                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
    );
  }//

  Widget containing(String text, var element ){


    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      padding: const EdgeInsets.only(top: 10),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Text(text,style: titleStyle,)),
          Text(element.toString(),style: titleLowerStyle,)
        ],
      ),
    );
  }
}
