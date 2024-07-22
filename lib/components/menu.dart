import 'dart:async';

import 'package:flutter/material.dart';

import 'data_class.dart';

class MenuWidget extends StatelessWidget {

  const  MenuWidget({super.key,  required this.menu});
  final List menu ;


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Container(
                color: Colors.blueAccent,
                height: 150,

                child:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('images/6.png',width: 70,height: 70),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: menuItems(context,menu),
            )

          ],
        ),
      );
  }

  Widget menuItems(BuildContext context,List items) {

    int n = items.length;
    List<Widget> widgets = [];
    for(int i=0;i<n;i++){
      widgets.add( Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTilePersonalize( tileInfo: items[i])
      ));
    }

    return Column(
      children: widgets,
    );
  }

}

class ListTilePersonalize extends StatefulWidget {
  const ListTilePersonalize({super.key,required this.tileInfo});
  final List tileInfo ;


  @override
  ListTilePersonalizeState createState() => ListTilePersonalizeState();
}

class ListTilePersonalizeState extends State<ListTilePersonalize> {

  bool _isClicked = false;
  late Timer timer1,timer2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  _isClicked ? Colors.blueAccent : Colors.white,
        borderRadius:  BorderRadius.circular(20),
        boxShadow:const  [BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 10)],
      ),
      child: ListTile(
        textColor: _isClicked ? Colors.white : Colors.blueAccent ,
        tileColor: Colors.white,
        selectedColor: Colors.white,
        title: Center(child: Text(widget.tileInfo[0],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),)),
        onTap: () {
          setState(() {
            _isClicked = !_isClicked;
          });
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              _isClicked = !_isClicked;
            });
          });

          Navigator.pushNamed(context,widget.tileInfo[1]);

        },
      ),
    );
  }
}
