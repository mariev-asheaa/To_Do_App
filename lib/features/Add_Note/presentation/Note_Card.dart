import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/features/Add_Note/models/Note_model.dart';
import 'package:to_do/features/Edit_Note/Edit_cubit/edit_cubit.dart';
import '../../Edit_Note/presentation/Edit_note.dart';
import '../view_models/Add_note_cubit/add_note_cubit.dart';
import 'Entering_data.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({required this.noteModel, required this.index, required this.onActiveStateChanged, required this.isForEditing});
   final NoteModel noteModel;
   final int index;
  final Function(bool) onActiveStateChanged;
  final bool isForEditing;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
       setState(() {
         isActive=true;
         widget.onActiveStateChanged(isActive);
       });
      },
      onTap: (){
        setState(() {
          isActive=false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.isForEditing
                ? BlocProvider(
              create: (context) => EditCubit(),
              child: EditNote(
                note: widget.noteModel,
                selectedNote: widget.index,

              ),
            )
                : BlocProvider(
              create: (context) => AddNoteCubit(),
              child: EnteringData(selectedNote: widget.index),
            ),
          ),
        );
      },
      child: SizedBox(
         height: MediaQuery.sizeOf(context).height*.3,
         width:MediaQuery.sizeOf(context).width*.5 ,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.noteModel.color,
            borderRadius: BorderRadius.circular(16),
            border:isActive? Border.all(
              color: Color(0xff725A03),
              width: 2
            ):null,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Image.asset(widget.noteModel.image),
              ),
              SizedBox(height: 10),
              Text(
                widget.noteModel.title,
                style: TextStyle(
                  color: widget.noteModel.textcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.noteModel.description,
                style: TextStyle(
                  color: widget.noteModel.textcolor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}