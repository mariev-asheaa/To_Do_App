import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/Note_model.dart';
import '../../presentation/Add_note_grid.dart';

part 'fetch_notes_state.dart';

class FetchNotesCubit extends Cubit<FetchNotesState> {
  FetchNotesCubit() : super(FetchNotesInitial());

  Future<void> fetchNotes() async {
    emit(FetchLoading());
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      List<NoteModel> fetchedNotes = querySnapshot.docs.map((doc) {

        return NoteModel(
          title: doc['Title'],
          description: doc['Description'],
          categoryIndex: doc['category'],
          color: AddNoteGrid.noteTypes[doc['category']].color,
          image: AddNoteGrid.noteTypes[doc['category']].image,
          textcolor: AddNoteGrid.noteTypes[doc['category']].textcolor,
        );
      }).toList();

      emit(FetchSuccess(notes: fetchedNotes));
    } catch (e) {print(e.toString());}
  }

}
