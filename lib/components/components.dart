import 'package:flutter/material.dart';
import 'package:true_finance/components/data_class.dart';

//ignore: must_be_immutable
class EntryField extends StatefulWidget {
  EntryField({super.key,required this.text,required this.type,required this.express,
              required this.control,required this.required,this.icon, required this.error});
  String  text, type;
  RegExp express;
  TextEditingController control;
  bool required;
  String error;
  Icon? icon;

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 35,right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:  10.0),
            child: Text(widget.text,style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white
            ),),
          ),
          TextFormField(
            readOnly:  widget.type == 'date'? true:false,
            showCursor: widget.type == 'date'? false:true,
            style: const TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16
            ),
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
            obscureText: widget.type == 'password' ? isObscured : false ,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 10),
                  child: widget.icon,
                ),
                prefixIconColor: colorApp,
                hoverColor: Colors.white,
                labelText: widget.text,
                labelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    color: colorApp,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none
                    )
                ),
                suffixIcon: widget.type == 'password'? IconButton(
                    padding: const EdgeInsetsDirectional.only(end: 12),
                    onPressed:(){
                      setState(() {
                        isObscured = isObscured == true ? false:true;
                      });
                    }
                    , icon: const Icon(Icons.visibility)
                ):null
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
        ],
      ),
    );
  }
}


class EntryFieldForm extends StatefulWidget {
  EntryFieldForm({super.key,required this.text,required this.type,required this.express,
    required this.control,required this.required,this.icon, required this.error});
  String  text, type;
  RegExp express;
  TextEditingController control;
  bool required;
  String error;
  Icon? icon;

  @override
  State<EntryFieldForm> createState() => _EntryFieldFormState();
}

class _EntryFieldFormState extends State<EntryFieldForm> {

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 35),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          readOnly:  widget.type == 'date'? true:false,
          showCursor: widget.type == 'date'? false:true,
          style: const TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16
          ),
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
          obscureText: widget.type == 'password' ? isObscured : false ,
          decoration: InputDecoration(
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              hoverColor: Colors.grey.withOpacity(0.1),
              labelText: widget.text,
              labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontSize: screenWidth*0.040,
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none
                  )
              ),
              suffixIcon: widget.type == 'password'? IconButton(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  onPressed:(){
                    setState(() {
                      isObscured = isObscured == true ? false:true;
                    });
                  }
                  , icon: const Icon(Icons.visibility)
              ):null
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
              style:const TextStyle(fontFamily: 'Roboto',color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
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
                const TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.blueAccent,
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
    padding:const EdgeInsets.only(bottom: 20,left: 15,right: 15),
    margin: const EdgeInsets.only(left: 15, right: 15,bottom: 40),
    child: Column(
      children: [
        Center(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'Roboto',
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


