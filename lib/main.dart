import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_network/src/injector_container.dart';
import 'package:for_network/src/presentation/bloc/home/home_bloc.dart';
import 'package:for_network/src/presentation/pages/home/home_page.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(const GetUsersEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
