import 'package:chat_app/app/bloc/auth_bloc.dart';
import 'package:chat_app/utils/show/app_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is! AuthLoadingState) {
              Navigator.pop(context);
            }
            if (state is AuthErrorState) {
              AppShow.showError(context, state.message);
            }
            if (state is AuthLoadingState) {
              AppShow.showLoading(context);
            }
            if (state is UnauthenticatedState) {
              AppShow.navigateWellComeUntil(context);
            }
          },
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return Text(state.user.email);
            } else {
              return const Text('Home');
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutEvent());
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: const Center(),
    );
  }
}
