import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//ignore: must_be_immutable
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
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius:  BorderRadius.circular(20),
          boxShadow:const  [BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 5)],
        ),
        child: TextFormField(
          readOnly:  widget.type == 'date'? true:false,
          showCursor: widget.type == 'date'? false:true,
          onTap: widget.type != 'date'? (){}:
              ()async{
            DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            widget.control.text = "${pickedDate?.day}-${pickedDate?.month}-${pickedDate?.year}";
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
            if(widget.required == true )
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

Widget emptyPage(String text,Widget addWidget){

  return Center(
    child: Container(
      width: 400,
      alignment: Alignment.center,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,textAlign: TextAlign.center,
              style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
            addWidget
          ],
        ),
      ),
    ),
  );
}

Widget header( String text) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      children: [
        Padding(
          padding:  const EdgeInsets.only( bottom: 10.0),
          child: Row(children: [
            const Icon(Icons.label_important, color: Colors.blueAccent,),
            Padding(
              padding:  const EdgeInsets.all(20.0),
              child: Text(text,
                style:
                const TextStyle(color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
            )
          ],),
        ),
      ],
    ),
  );
}

Widget content(String text, Widget widget) {
  return Container(
    padding:const EdgeInsets.only(bottom: 20),
    margin: const EdgeInsets.only(left: 30, right: 30,bottom: 40),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.blueAccent,width: 1),
      boxShadow: const [BoxShadow(
          color: Colors.grey,
          offset: Offset(2, 2),
          blurRadius: 5)], //Bo,
    ),
    child: Column(
      children: [
        Center(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                text,
                style: GoogleFonts.actor(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),),
            ),
            widget

          ],
        )),
      ],
    ),
  );
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

