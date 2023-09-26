import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_network/src/injector_container.dart';
import 'package:for_network/src/presentation/bloc/add_user/add_user_bloc.dart';
import 'package:for_network/src/presentation/bloc/home/home_bloc.dart';
import 'package:for_network/src/presentation/pages/internet_connection/internet_connection_page.dart';
import 'package:for_network/src/presentation/pages/add_user/new_user_page.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInternet();
  }

  Future<void> getInternet() async {
    var noNetwork = await InternetConnectionChecker().hasConnection;
    if (!noNetwork) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const InternetConnectionPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
            centerTitle: true,
            backgroundColor: Colors.lightBlue,
          ),
          body: state.getStatus == GetUsersStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: state.usersList?.data?.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                        state.usersList?.data?[index].avatar ?? ''),
                  ),
                ),
                title:
                Text(state.usersList?.data?[index].firstName ?? ''),
                subtitle: Text(state.usersList?.data?[index].email ?? ''),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (context) => sl<AddUserBloc>(),
                  child: const NewUserPage(),
                );
              }));
            },
          ),
        );
      },
    );
  }
}
