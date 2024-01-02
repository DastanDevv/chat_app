import 'package:chat_app/app/bloc/auth_bloc.dart';
import 'package:chat_app/wellcome/wellcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.storage});

  final SharedPreferences storage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        // Инициализируйте AuthBloc с экземпляром FirebaseAuth и хранилищем
        auth: FirebaseAuth.instance,
        storage: storage,
      )..add(AuthInitialEvent()),
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
