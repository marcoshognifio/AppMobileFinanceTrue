
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
    return  Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 35),
        child: SizedBox(
            height: 50,
            child: TextButton(
              style:  ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(0.2),
                minimumSize: const Size.fromHeight(50),
                padding:const  EdgeInsets.only(top: 15, bottom: 15,left: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed:()async {
                final ImagePicker picker = ImagePicker();
                widget.imageFile =
                await picker.pickImage(source: ImageSource.gallery);
                if (widget.imageFile != null) {
                  setState(() {
                    widget.textDisplay = widget.imageFile!.name;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.textDisplay,style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: screenWidth*0.040,
                      )),
                  ),
                ],
              ),
            )
        )
    );
  }
}
