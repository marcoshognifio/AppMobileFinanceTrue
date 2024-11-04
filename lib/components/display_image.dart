import 'package:flutter/material.dart';

//ignore: must_be_immutable
class DisplayImage extends StatelessWidget {
  DisplayImage({super.key,required this.imageUrl});
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Image.network(imageUrl)
              )
          ),
        ),
    );
  }
}
