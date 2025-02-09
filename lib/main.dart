import 'package:custom_dropdown_with_searchfeild/custom_dropdown_with_search.dart';
import 'package:flutter/material.dart';

import 'custom_dropdown_with_multiselect.dart';
import 'custom_dropdown_with_textfield.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
/// GTest

class _MyAppState extends State<MyApp> {

  String value1 ="Hello";
  String value2 ="Hello";
  String value3 ="Hello";
  List<String>valueList=["Hello","World","Mirza","Good","Morning","Code"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:const  Text("Custom Dropdown"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              DropDownWithSearchField(selectedFilter: value1, filterList: valueList, onChange: (val){
                setState(() {
                  value1=val;
                });
              }),
              const SizedBox(height: 20,),
              DropDownWithSearchAndMultiSelect(selectedFilter: value1, filterList: valueList, onChange: (val){
                setState(() {
                  value2=val;
                });
              }),
              const SizedBox(height: 20,),
              DropDownWithSearchAndTextField(selectedFilter: value1, filterList: valueList, onChange: (val){
                setState(() {
                  value3=val;
                });
              }),

              const Spacer(flex: 2,),
            ],
          ),
        ),
      )
    );
  }
}
