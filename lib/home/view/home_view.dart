import 'package:chat_app/app/bloc/auth_bloc.dart';
import 'package:chat_app/chat/chat.dart';
import 'package:chat_app/components/components.dart';
import 'package:chat_app/home/cubit/home_cubit.dart';
import 'package:chat_app/models/user_model.dart';
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
  void initState() {
    context.read<HomeCubit>().getUsers();
    super.initState();
  }

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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const LoadingWidget(),
            HomeLoading() => const LoadingWidget(),
            HomeError() => CustomErrorWidget(state.message),
            HomeSuccess() => HomeSuccessWidget(state.users),
          };
        },
      ),
    );
  }
}

class HomeSuccessWidget extends StatelessWidget {
  const HomeSuccessWidget(this.users, {super.key});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    // Delete current user from list
    // final state = context.read<AuthBloc>().state;
    // if (state is AuthenticatedState) {
    //   users.removeWhere((e) => e.uid == state.user.uid);
    // }
    return ListView.builder(
      itemCount: users.length,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Text('${index + 1}'),
            title: Text(users[index].email),
            subtitle: Text(users[index].uid),
            onTap: () {
              final authBloc = context.read<AuthBloc>();
              if (authBloc.state is AuthenticatedState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      secondUser: users[index],
                      currentUser: (authBloc.state as AuthenticatedState).user,
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
