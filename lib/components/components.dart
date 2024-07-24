import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EntryField extends StatefulWidget {
  EntryField({super.key,required this.text,required this.type,required this.express,
              required this.control,required this.required,required this.error});
  String  text, type;
  RegExp express;
  TextEditingController control;
  bool required;
  String error;

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 15),
      child: SizedBox(
        width: 350,
        child: TextFormField(
          onTap: widget.type != 'date'? (){}:
              ()async{
            DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
          },
          controller: widget.control,
          obscureText: widget.type == 'password',
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hoverColor: Colors.white,
              labelText: widget.text,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none
                  )
              )
          ),
          validator: (value) {
            if(required == true )
            {
              if(value!.isEmpty){
                return 'Ce champ est obligatoire';
              }
              if (!widget.express.hasMatch(value))
              {
                return widget.error;
              }
              return null;
            }
            else
            {
              if (value!.isNotEmpty && !widget.express.hasMatch(value))
              {
                return widget.error;
              }
              else {
                return null;
              }
            }
          },
        ),
      ),
    );
  }
}


/*    else
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

}*/

