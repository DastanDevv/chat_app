import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.db) : super(HomeInitial());

  final FirebaseFirestore db;

  /// Извлекает пользователей из коллекции 'users' в базе данных.
  /// Emits [HomeLoading] состояние перед выполнением вызова API.
  /// Emits [HomeSuccess] состояние с найденными пользователями в случае успеха.
  /// Emits [HomeError] состояние с сообщением об ошибке при неудаче.
  Future<void> getUsers() async {
    emit(HomeLoading());
    try {
      final data = await db.collection('users').get();
      log('${data.docs}');
      final users = data.docs.map((e) => User.fromJson(e.data())).toList();
      log('$users');
      emit(HomeSuccess(users));
    } catch (e) {
      log('$e');
      emit(HomeError(e.toString()));
    }
  }
}
