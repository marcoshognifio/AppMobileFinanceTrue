
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//ignore: must_be_immutable
class GetImage extends StatefulWidget {
  GetImage({super.key,required this.textDisplay});
   XFile? imageFile;
    String textDisplay;


    XFile? getImageFile(){
      return imageFile;
    }


  @override
  GetImageState createState() => GetImageState();
}



class GetImageState extends State<GetImage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child: Container(
            width: 350,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  blurRadius: 10)
              ],
            ),
            child: ElevatedButton(
              onPressed: ()async {
                final ImagePicker picker = ImagePicker();
                widget.imageFile = await picker.pickImage(source: ImageSource.gallery);

                if(widget.imageFile != null){
                  setState(() {
                    widget.textDisplay =widget.imageFile!.name;
                  });
                }
              },
              child: Text(widget.textDisplay),
            ),

        )
    );
  }
}
