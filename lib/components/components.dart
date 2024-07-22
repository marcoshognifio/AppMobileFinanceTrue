import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget entryfield (String  text,String type,RegExp express,TextEditingController control) {

  late Widget aide ;

    if(type != "image")
    {
        aide =  TextFormField(
          controller: control,
          obscureText: type == 'password',
          decoration:  InputDecoration(
              prefixIcon:const Icon(Icons.email_outlined,color: Colors.blueAccent,) ,
              labelText: text,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0 )),
                  borderSide:  BorderSide(
                      width: 0,
                      style: BorderStyle.none
                  )
              )
          ),
          validator: (value) {
            if(value!.isEmpty || !express.hasMatch(value)) {
              return 'Ce champ est obligatoire';
            }
            else {
              return null;
            }
          },
        );
    }

    else
    {
      aide  = const ElevatedButton(
        onPressed: _pickImage,
        child: Text('Choisir une image'),
      );
    }

  return   aide;

}

Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

}

Widget entryField (String  text,String type,RegExp express,TextEditingController control) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0, top: 15),
    child: SizedBox(
      width: 350,
      child: TextFormField(

        controller: control,
        obscureText: type == 'password',
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hoverColor: Colors.white,
            labelText: text,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none
                )
            )
        ),
        validator: (value) {
          if (value!.isEmpty || !express.hasMatch(value)) {
            return 'Ce champ est obligatoire';
          }
          else {
            return null;
          }
        },
      ),
    ),
  );
}
