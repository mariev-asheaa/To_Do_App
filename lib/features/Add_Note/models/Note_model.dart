import 'package:flutter/cupertino.dart';

class NoteModel{
   String title;
   String description;
  final Color color;
  final String image;
  final Color textcolor;
  final int categoryIndex;

   NoteModel({required this.title, required this.description,required this.color,required this.image,required this.textcolor,required this.categoryIndex});

}