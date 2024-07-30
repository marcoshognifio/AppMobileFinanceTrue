
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      padding: const EdgeInsets.only(top: 0, bottom: 20),
      child:Container(
          width: 350,
          decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius:  BorderRadius.circular(20),
            boxShadow:const  [BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 5)],
          ),
          child: Column(
            children: [
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none
                          )
                      )
                  ),
                  value: selectedValue,
                  hint: const Text("Choisissez le projet "),
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
        
            ],
          ),
        ),
    );
  }

  List<DropdownMenuItem<int>> listItems(List<Map<String,dynamic>> list)
  {
    List<DropdownMenuItem<int>> result = [];
    for(int i=0,c = list.length;i<c;i++){
      result.add(DropdownMenuItem(value: list[i]["value"],
          child:Text(list[i]["label"])));
    }
    return result;
  }
}



