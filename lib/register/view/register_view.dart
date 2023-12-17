import 'dart:developer';
import 'package:chat_app/app/bloc/auth_bloc.dart';
import 'package:chat_app/components/components.dart';
import 'package:chat_app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final _confirmPasswordCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomeView(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/thunder.svg', height: 100),
              const SizedBox(height: 20),
              CustomTextFlied(
                controller: _emailCtl,
                labelText: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextFlied(
                controller: _passwordCtl,
                labelText: 'Password',
              ),
              const SizedBox(height: 20),
              CustomTextFlied(
                controller: _confirmPasswordCtl,
                labelText: 'Confirm Password',
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                text: 'Register',
                onPressed: () {
                  if (checkForm()) {
                    final registerEvent = AuthRegisterEvent(
                      email: _emailCtl.text,
                      password: _passwordCtl.text,
                    );

                    context.read<AuthBloc>().add(registerEvent);
                  } else {
                    log('Form is not valid');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkForm() {
    if (_emailCtl.text.isNotEmpty &&
        _passwordCtl.text.isNotEmpty &&
        _confirmPasswordCtl.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
