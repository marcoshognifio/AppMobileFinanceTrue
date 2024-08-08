
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'data_class.dart';

//ignore: must_be_immutable
class GetImage extends StatefulWidget {
  GetImage({super.key,required this.textDisplay,required this.type});
   XFile? imageFile;
    String textDisplay;
    String type;

    XFile? getImageFile(){
      return imageFile;
    }

    Future<Map> saveImage() async{

      if(imageFile != null){
        late Map body;
        Uri uri = Uri.parse("$url/api/save_image");
        var request = http.MultipartRequest('POST', uri)
          ..files.add(await http.MultipartFile.fromPath('image', imageFile!.path));

        request.fields['type'] = type;
        request.headers.addAll({
          "Authorization": "Bearer $token"
        });
        http.Response response = await http.Response.fromStream(
            await request.send());
        if (response.statusCode == 200) {
          body = jsonDecode(response.body);
          return body;
        }
        else {
          return {};
        }
      }
      else{
        return {};
      }

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
