import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:to_do/features/Add_Note/view_models/Fetch_notes_cubit/fetch_notes_cubit.dart';
import '../../../core/constants.dart';
import '../../Home/presentation/Home.dart';
import '../view_models/Add_note_cubit/add_note_cubit.dart';


class EnteringData extends StatefulWidget {
  const EnteringData({super.key, required this.selectedNote});

  final int selectedNote;

  @override
  State<EnteringData> createState() => _EnteringDataState();
}

class _EnteringDataState extends State<EnteringData> {
  String title = "";
  String description = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  hintText: "Title Here",
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
          if (title.isEmpty && description.isEmpty) {
            Dialogs.materialDialog(
              color: Colors.white,
              msg:'Title and description cannot be empty!',
              msgStyle: const TextStyle(
                fontSize: 20,
                color: kprimary,
                fontWeight: FontWeight.bold,
              ),
              dialogWidth: 1,
              context: context,
            );
          } else {
            context.read<AddNoteCubit>().addNote(
              title: title,
              desc: description,
              categoryIndex: widget.selectedNote,
            );
            context.read<FetchNotesCubit>().fetchNotes();
            Navigator.popAndPushNamed(context,Home.id);
          }

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
