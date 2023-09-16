import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_network/src/presentation/bloc/add_user/add_user_bloc.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPAgeState();
}

class _NewUserPAgeState extends State<NewUserPage> {
  final firstNameContr = TextEditingController();
  final jobNameContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('New User'),
          ),
          body: Column(
            children: [
              TextField(
                controller: firstNameContr,
              ),
              TextField(
                controller: jobNameContr,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AddUserBloc>().add(AddOneUserEvent(name: firstNameContr.text, job: jobNameContr.text));
                },
                child: const Text('Add User'),
              ),
              const SizedBox(height: 50,),
              Text(state.user?.name??''),
              Text(state.user?.job??''),
              Text(state.user?.createdAt??''),
              Text(state.user?.id??''),
            ],
          ),
        );
      },
    );
  }
}
