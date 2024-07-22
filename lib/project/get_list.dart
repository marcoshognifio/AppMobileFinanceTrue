
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class GetList extends StatefulWidget {
  GetList({super.key,required this.listItems});
  final List<Map<String,dynamic>> listItems ;
  int?  selectedValue;
  @override
  GetListState createState() => GetListState();

  getSelectedValue() => selectedValue;

}

class GetListState extends State<GetList> {

  List<DropdownMenuItem> listButton = [];


 @override
  void initState() {
    widget.selectedValue = widget.listItems[1]['value'];
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child:Container(
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
          child: DropdownMenu(
            width: 360,
            inputDecorationTheme:
                const InputDecorationTheme(border:OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0 )),
                    borderSide:  BorderSide(
                        width: 0,
                        style: BorderStyle.none
                    )
                )),
            label:const Text("Choisissez le projet destinataire"),
            dropdownMenuEntries: listItems(widget.listItems),
            onSelected: (item){
              if(item !=null){
                setState(() {
                  widget.selectedValue = item;
                });
              }
            },

          ),
        ),
    );
  }

  List<DropdownMenuEntry<int>> listItems(List<Map<String,dynamic>> list)
  {
    List<DropdownMenuEntry<int>> result = [];
    for(int i=0,c = list.length;i<c;i++){
      result.add(DropdownMenuEntry(value: list[i]["value"], label: list[i]["label"]));
    }
    return result;
  }
}
