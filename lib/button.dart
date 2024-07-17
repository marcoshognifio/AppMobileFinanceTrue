

import 'package:flutter/material.dart';

Widget buttonWidget(String text, VoidCallback onTap, BuildContext context) {

  TextStyle textStyle=const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 5,
      letterSpacing: 3);

  return  Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Row(
        children: [
          Expanded(
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:const  EdgeInsets.only(top: 15, bottom: 15),
                  elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: onTap,
              child: Text(text,style: textStyle),
            ),
          )
       ]
    ),
  );
}
