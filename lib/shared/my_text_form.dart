import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatefulWidget {
  MyTextFormField({super.key,

    required this.hintText,
    required this.controller,
    required this.label,

this.isEnabled=true,
    this.visability = true,
    this.isPassword = false,
    required this.type,
    this.onTapFunction,

    required this.prefix });
  TextEditingController controller;
  final VoidCallback? onTapFunction;

  IconData? prefix;
  bool visability,isEnabled, isPassword;
  String hintText, label;
  TextInputType type;
  //Function? validator;


  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      obscureText: widget.isPassword ? widget.visability : false,
      onTap:widget.onTapFunction,

      controller: widget.controller,
     validator:( value){
       if (value!.isEmpty) {
         print("value is empty");
         return "you must add ${widget.label}";

       }
       return null;
      // print("value is not empty
       // ");

     } ,//widget.validator!(),
      decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.label,
          suffixIcon: widget.isPassword
              ? widget.visability
              ? IconButton(
            icon: const Icon(Icons.visibility), onPressed: () {
            setState(() {
              widget.visability = !widget.visability;
            });
          },)
              : IconButton(
            icon: const Icon(Icons.visibility_off), onPressed: () {
            setState(() {
              widget.visability = !widget.visability;
            });
          },)
              : null,
          prefixIcon: Icon(widget.prefix),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.r)))),

    );
  }
}
