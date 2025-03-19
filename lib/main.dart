import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/features/Add_Note/presentation/Entering_data.dart';
import 'package:to_do/features/Add_Note/view_models/Fetch_notes_cubit/fetch_notes_cubit.dart';
import 'package:to_do/firebase_options.dart';

import 'features/Add_Note/presentation/Add_Note.dart';
import 'features/Home/presentation/Home.dart';
import 'features/LogIn/presentation/Log_In.dart';
import 'features/SignUp/presentation/Sign_Up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ToDo());
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _e_commerceState();
}

class _e_commerceState extends State<ToDo> {
  @override
  void initState() {
    //provide user state
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNotesCubit()..fetchNotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: const Login(),
        // home: FirebaseAuth.instance.currentUser==null? const Login():const Homeview(),
        routes: {
          Home.id: (context) => const Home(),
          SignUp.id: (context) => const SignUp(),
          Login.id: (context) => const Login(),
          AddNote.id: (context) => const AddNote(),

        },
      ),
    );
  }
}
