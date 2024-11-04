

import 'package:flutter/material.dart';
import 'package:true_finance/components/data_class.dart';

//ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, required this.text, required this.onTap});
   final String text;
   final VoidCallback onTap;

  TextStyle textStyle=const TextStyle(
      fontFamily: "Roboto",
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      wordSpacing: 3,
      letterSpacing: 1);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,left: 35,right: 35),
      child: SizedBox(
        height: 50,
        child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: colorApp, //Color(0xff2f52f6),
                    padding:const  EdgeInsets.only(top: 15, bottom: 15),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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

