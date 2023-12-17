import 'package:chat_app/components/components.dart';
import 'package:chat_app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/thunder.svg',
              height: 90,
            ),
            const SizedBox(height: 20),
            const CustomTextFlied(
              labelText: 'Email',
              controller: null,
            ),
            const SizedBox(height: 20),
            const CustomTextFlied(
              labelText: 'Password',
              controller: null,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Login',
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
