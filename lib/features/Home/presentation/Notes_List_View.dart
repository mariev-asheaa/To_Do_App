import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/constants.dart';
import 'package:to_do/features/Add_Note/presentation/Note_Card.dart';
import 'package:to_do/features/Add_Note/view_models/Fetch_notes_cubit/fetch_notes_cubit.dart';




class NotesListView extends StatelessWidget {
  const NotesListView({super.key, required this.onNoteCardActiveStateChanged, required this.categoryIndex});
  final Function(bool) onNoteCardActiveStateChanged;
  final int categoryIndex;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNotesCubit, FetchNotesState>(
      builder: (context, state) {
        if(state is FetchLoading){
          return Center(child: CircularProgressIndicator(),);
        }
       else if (state is FetchSuccess) {
          var categoryNotes =
          state.notes.where((note) => note.categoryIndex == categoryIndex).toList();

          return categoryNotes.isEmpty
              ? const Center(child: Text("Start Adding Notes Now!" ,
            style: TextStyle(fontWeight: FontWeight.bold,color: kprimary)
            ,)
          )
              :AspectRatio(
               aspectRatio: 40 / 30,
               child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: categoryNotes.length,
               itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                   child: NoteCard(
                     noteModel: categoryNotes[index],
                     index: categoryNotes[index].categoryIndex,
                     onActiveStateChanged: onNoteCardActiveStateChanged,
                     isForEditing: true,
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text("Start Adding Notes Now!",
            style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: kprimary),
          )
          );
        }
      },
    );
  }
}
