import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../../core/constants.dart';
import '../../AuthBloc/auth_bloc.dart';
import '../../Home/presentation/Home.dart';
import 'SignUp_Body.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key,});

  static String id='SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is EmailVerification) {
            Dialogs.materialDialog(
              color: Colors.white,
              msg: "A verification email has been sent. Please verify your email.",
              msgStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              title: 'Verify Email',
              titleStyle: const TextStyle(
                color: kprimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              dialogWidth: 1,
              context: context,
            );
          }
          else if (state is RegisterSuccess) {
            Navigator.pushReplacementNamed(context, Home.id);
          }
          else if(state is RegisterFailur){
            Dialogs.materialDialog(
              color: Colors.white,
              msg: state.errormessage,
              msgStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              titleStyle: const TextStyle(
                  color: kprimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),
              title: 'Error',
              dialogWidth:1,
              context: context,
            );
          }
        },
        builder: (context, state) {
          return const Scaffold(
              body: SafeArea(child: SignUpBody())
          );
        },
      ),
    );
  }
}

