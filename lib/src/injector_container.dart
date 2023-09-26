import 'package:chuck_interceptor/chuck.dart';
import 'package:dio/dio.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:for_network/src/core/constants.dart';
import 'package:for_network/src/domain/network/api_client.dart';
import 'package:for_network/src/domain/repositories/add_user_repository.dart';
import 'package:for_network/src/domain/repositories/home_repository.dart';
import 'package:for_network/src/presentation/bloc/add_user/add_user_bloc.dart';
import 'package:for_network/src/presentation/bloc/home/home_bloc.dart';
import 'package:for_network/src/presentation/pages/internet_connection/internet_connection_page.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: 'application/json',
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      )
      ..interceptors.addAll(
        [
          LogInterceptor(
            requestBody: kDebugMode,
            responseBody: kDebugMode,
          ),
          if (kDebugMode) chuck.getDioInterceptor(),
        ],
      ),
  );
  sl<Dio>().interceptors.add(
        RetryInterceptor(
          dio: sl<Dio>(),
          toNoInternetPageNavigator: () async =>
              Navigator.push(Constants.navigatorKey.currentContext!,
                  MaterialPageRoute(builder: (context) {
            return const InternetConnectionPage();
          })),
          refreshTokenFunction: () async {
            // await Navigator.pushNamedAndRemoveUntil(
            //   Constants.navigatorKey.currentContext!,
            //   Routes.initial,
            //   (route) => false,
            // );
          },
        ),
      );

  sl
    ..registerLazySingleton(InternetConnectionChecker.new)
    ..registerFactory<ApiClient>(
      () => ApiClient(
        sl(),
      ),
    );

  _mainPage();

  /// add user
  _addFeature();
}

void _mainPage() {
  sl
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepository(
        apiClient: sl(),
      ),
    )
    ..registerFactory(() => HomeBloc(
          homeRepository: sl(),
        ));
}

void _addFeature() {
  sl
    ..registerLazySingleton<AddUserRepository>(
      () => AddUserRepository(
        apiClient: sl(),
      ),
    )
    ..registerFactory(() => AddUserBloc(
          addRepository: sl(),
        ));
}

Chuck chuck = Chuck(navigatorKey: Constants.navigatorKey);
