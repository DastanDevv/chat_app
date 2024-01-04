import 'package:chat_app/app/bloc/auth_bloc.dart';
import 'package:chat_app/home/cubit/home_cubit.dart';
import 'package:chat_app/wellcome/wellcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.storage});

  final SharedPreferences storage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            auth: FirebaseAuth.instance,
            storage: storage,
            db: FirebaseFirestore.instance,
          )..add(AuthInitialEvent()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WellComeView(),
      ),
    );
  }
}
