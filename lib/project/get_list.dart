
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/data_class.dart';

//ignore: must_be_immutable
class GetList extends StatelessWidget {
  GetList({super.key,required this.items});
  final List<Map<String,dynamic>> items ;
  int?  selectedValue;

  getSelectedValue(){
    if(selectedValue == null){
      return -1;
    }
    return  selectedValue;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 35),
      child:SizedBox(
        height: 50,
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              decoration: InputDecoration(
                  fillColor:Colors.grey.withOpacity(0.1),
                  filled: true,
                  hoverColor: Colors.white,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none
                      )
                  )
              ),
              value: selectedValue,
              hint: Text("Choisissez le projet ",style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: screenWidth*0.040,
                  color: Colors.black),),
              items: listItems(items),
              onChanged: (int? value) {
                if(value != null){
                  selectedValue = value;
                }
              },
              validator: (value) {
                if (value == null ) {
                  return 'Veuillez sélectionner une option';
                }
                return null;
              }

          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> listItems(List<Map<String,dynamic>> list)
  {
    List<DropdownMenuItem<int>> result = [];
    for(int i=0,c = list.length;i<c;i++){
      result.add(DropdownMenuItem(value: list[i]["value"],
          child:Text(list[i]["label"],style: const TextStyle(fontFamily: 'Roboto-Regular',),)));
    }
    return result;
  }
}



