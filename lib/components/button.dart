

import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, required this.text, required this.onTap});
   final String text;
   final VoidCallback onTap;

  TextStyle textStyle=const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      wordSpacing: 3,
      letterSpacing: 1);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: 350,
        child: Row(
            children: [
              Expanded(
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, //Color(0xff2f52f6),
                    padding:const  EdgeInsets.only(top: 15, bottom: 15),
                    elevation: 2,
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
      ),
    );
  }
}

