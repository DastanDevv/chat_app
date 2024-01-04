import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as authPkg;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const _emailKey = 'email-key';
const _passwordKey = 'password-key';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.db,
    required this.auth,
    required this.storage,
  }) : super(UnauthenticatedState()) {
    on<AuthEvent>((event, emit) {});
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
    on<AuthLogoutEvent>(_logout);
    on<AuthInitialEvent>(_init);
  }

  final authPkg.FirebaseAuth auth;
  final SharedPreferences storage;
  final FirebaseFirestore db;

  /// Этот метод отвечает за загрузку сохраненных электронной почты и пароля пользователя из хранилища,
  /// и попытку входа в систему с полученными учетными данными. Если авторизация прошла успешно,
  /// он выдает [AuthenticatedState]  с информацией о пользователе. Если сохраненные электронная почта и пароль
  /// недоступны или регистрация не удалась, он выдает сообщение [UnauthenticatedState].
  Future<void> _init(AuthInitialEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    try {
      // Извлечаем сохраненные электронную почту и пароль из хранилища
      final email = storage.getString(_emailKey);
      final password = storage.getString(_passwordKey);

      if (email != null && password != null) {
        // Войдите в систему с полученными учетными данными
        final fUser = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        log('$fUser');

        // Создать объект User с указанием электронной почты и пароля
        final appUser = User(email: email, password: password);

        //Выдаем AuthenticatedState с информацией о пользователе
        emit(AuthenticatedState(appUser));
      } else {
        // Сохраненные email и пароль не найдены, выдаем UnauthenticatedState
        emit(UnauthenticatedState());
      }
    } catch (e) {
      // Произошла ошибка при входе в систему, выдайте UnauthenticatedState
      emit(UnauthenticatedState());
    }
  }

  /// Входит в систему с помощью указанного email и пароля.
  Future<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      // Выдаем AuthLoadingState, чтобы указать что процесс входа в систему начался.
      emit(AuthLoadingState());

      // Вход в систему с указанными электронной почтой и паролем с помощью объекта `auth`.
      final fUser = await auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      log('$fUser');

      // Создание нового объекта `User` с указанием электронной почты и пароля.
      final appUser = User(email: event.email, password: event.email);

      // Хранение электронной почты и пароля в локальном хранилище.
      await storage.setString(_emailKey, event.email);
      await storage.setString(_passwordKey, event.password);

      // Выдача AuthenticatedState с объектом `appUser` для обозначения успешной аутентификации.
      emit(AuthenticatedState(appUser));
    } catch (e) {
      log('$e');

      // Выдача AuthErrorState с сообщением об ошибке, указывающим на ошибку входа в систему.
      emit(AuthErrorState(e.toString()));
    }
  }

  /// Регистрирует нового пользователя с указанными электронной почтой и паролем.
  /// Этот метод создает новую учетную запись пользователя с помощью метода `createUserWithEmailAndPassword`
  /// из объекта `auth`.
  /// Наконец, он выдает соответствующее состояние, основанное на результатах процесса регистрации.
  Future<void> _register(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      final fUser = await auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Введите идентификатор пользователя Firebase
      log('firebase user uid ${fUser.user?.uid}');

      // Зарегистрируйте объект пользователя Firebase
      log('$fUser');

      // Создание новый объект пользователя приложения
      final appUser = User(email: event.email, password: event.email);

      // Добавление нового пользователя в коллекцию `users` в Firebase

      await db.collection("users").add(appUser.toJson());

      // Сохраните электронную почту и пароль пользователя в локальном хранилище
      await storage.setString(_emailKey, event.email);
      await storage.setString(_passwordKey, event.password);

      // Передача аутентифицированного состояния с объектом пользователя приложения
      emit(AuthenticatedState(appUser));
    } catch (e) {
      // все ошибки, возникающие в процессе регистрации
      log('$e');
      emit(AuthErrorState(e.toString()));
    }
  }

  /// Этот метод выводит пользователя из системы и удаляет сохраненные email и пароль,
  /// и выдает [UnauthenticatedState] в случае успеха. Если произошла какая-либо ошибка,
  /// он регистрирует ошибку и выдает [AuthErrorState].
  Future<void> _logout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState()); // Выдаем состояние загрузки
      await Future.delayed(
          const Duration(seconds: 1)); // искусственная задержка
      await auth.signOut(); // Выход пользователя из системы

      await storage.remove(
          _emailKey); // Удаление сохраненных сообщений электронной почты
      await storage.remove(_passwordKey); // Удаление сохраненного пароля

      emit(
          UnauthenticatedState()); // Emit неаутентифицированного состояния для обозначения успешного выхода из системы
    } catch (e) {
      log('$e'); // Зафиксируйте ошибку
      emit(AuthErrorState(
          e.toString())); //Выдаем состояние ошибки с сообщением об ошибке
    }
  }
}
