import 'package:chat_app/home/home.dart';
import 'package:chat_app/wellcome/view/well_come_view.dart';
import 'package:flutter/material.dart';

class AppShow {
  /// Displays a snackbar with the given [message] in the [context].
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Отображает диалог индикатора загрузки в [context].
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SizedBox(
          height: 35,
          width: 35,
          child: FittedBox(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  /// Переход к главному виду и удаление всех других маршрутов из стека в [context].
  static void navigateHomeUntil(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeView()),
      (Route route) => false,
    );
  }

  /// Переходит к представлению приветствия и удаляет все остальные маршруты из стека в [context].
  static void navigateWellComeUntil(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WellComeView()),
      (Route route) => false,
    );
  }

  /// Показывает диалог ошибки с заданным[message] в [context].
  static void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
