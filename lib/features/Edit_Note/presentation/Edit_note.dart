import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/features/Add_Note/models/Note_model.dart';

import '../../../core/constants.dart';
import '../../Add_Note/view_models/Fetch_notes_cubit/fetch_notes_cubit.dart';
import '../../Home/presentation/Home.dart';
import '../Edit_cubit/edit_cubit.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.note, required this.selectedNote,});

 final NoteModel note;
  final int selectedNote;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
 late String title ;
 late String description;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 List<QueryDocumentSnapshot>data=[];
  getData()async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('notes').get();
   setState(() {
     data=querySnapshot.docs;
   });
  }

 @override
 void initState() {
   super.initState();
   title = widget.note.title;
   description = widget.note.description;
   getData();
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios, color: kprimary, size: 16),
                    ),
                    const Text('Back', style: TextStyle(color: kprimary, fontSize: 14)),
                  ],
                ),
                TextField(
                  onChanged: (data) {
                    setState(() {
                      title = data;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "New Title",
                    hintStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                TextField(
                  onChanged: (data) {
                    setState(() {
                      description = data;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Write your notes here...",
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                  maxLines: 25,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
             widget.note.title=title;
             widget.note.description=description;

             context.read<EditCubit>().editNote(
               title: title,
               description: description,
               categoryIndex: widget.selectedNote,
               docId:data[widget.selectedNote].id,
             );
              context.read<FetchNotesCubit>().fetchNotes();
              Navigator.popAndPushNamed(context,Home.id);
          },
          backgroundColor: Colors.purple,
          elevation: 2.0,
          shape: CircleBorder(),
          child: Icon(Icons.check, color: Colors.white),
        ),
      ),
    );
  }
}
