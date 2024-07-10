import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Padding entryfield (String  text,String type,RegExp express,TextEditingController control) {

  late Widget aide ;

    if(type != "image")
    {
        aide =  TextFormField(
          controller: control,
          obscureText: type == 'password',
          decoration:  InputDecoration(
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

  return Padding(
    padding: const EdgeInsets.only(
        top: 0, bottom: 20),
    child: Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius:  BorderRadius.circular(20),
        boxShadow:const  [BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 10)],
      ),
      child: aide,
    ),
  );

}

Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

}