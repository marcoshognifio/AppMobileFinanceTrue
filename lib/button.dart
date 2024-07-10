

import 'package:flutter/material.dart';

Padding loginButton(String text,String route, BuildContext context) {

  TextStyle textStyle=const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 5,
      letterSpacing: 3);

  return Padding(
    padding: const EdgeInsets.only(left: 50,right: 50 , bottom: 20),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.lightBlue
            ),

            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            child: Text(text,style: textStyle),
          ),
        ),
      ],
    ),
  );
}