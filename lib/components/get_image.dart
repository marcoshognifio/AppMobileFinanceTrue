
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

//ignore: must_be_immutable
class GetImage extends StatefulWidget {
  GetImage({super.key,required this.textDisplay});
   XFile? imageFile;
    String textDisplay;
    late String image;

    String imageString(){
      return image;
    }


  @override
  GetImageState createState() => GetImageState();
}



class GetImageState extends State<GetImage> {

  late String textButton;
  @override
  void initState() {
    textButton = widget.textDisplay;
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

                    textButton =widget.imageFile!.name;
                    final imageBytes = widget.imageFile?.readAsBytes();
                    final bytes = await widget.imageFile?.readAsBytes();

                    // Encoder en base64
                    widget.image = base64Encode(bytes as List<int>);
                    //final base64Image = base64Encode(imageBytes as List<int>);
                    //Uri image = Uri.dataFromBytes((await widget.imageFile?.readAsBytes()) as List<int>, mimeType: 'image/png');
                    //await MultipartFile.fromFile(widget.imageFile!.path,filename: 'image',contentType: MediaType('image','png'));
                    print('bonjour');


                }
              },
              child: Text(textButton),
            ),

        )
    );
  }
}
