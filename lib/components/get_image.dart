
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImage extends StatefulWidget {
  GetImage({super.key,required this.textDisplay});
  XFile? imageFile;
  String textDisplay;
  @override
  GetImageState createState() => GetImageState();

  String? getNameImage()
  {
    return imageFile?.name;
  }
}

class GetImageState extends State<GetImage> {

  late String textButton;
  @override
  void initState() {
    textButton = widget.textDisplay;
    super.initState();
  }

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      widget.imageFile = image;
      textButton = image!.name;
    });
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
              onPressed: _getImage,
              child: Text(textButton),
            ),

        )
    );
  }
}
