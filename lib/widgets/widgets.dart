import 'package:flutter/material.dart';

AppBar appBar(){
  return AppBar(
    title: Text("Temp Check"),
  );
}

InputDecoration textFieldInputDecoration(String hint){
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
          color: Colors.white54
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}