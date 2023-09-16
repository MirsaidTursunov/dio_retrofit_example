import 'package:chuck_interceptor/chuck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:for_network/src/core/constants.dart';
import 'package:for_network/src/data/models/get_one_user_response.dart';
import 'package:for_network/src/data/models/get_user_response.dart';
import 'package:for_network/src/data/models/post_user_request.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

Chuck alice = Chuck(
  navigatorKey: Constants.navigatorKey,
  showInspectorOnShake: true,
);
@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    dio.options = BaseOptions(
      contentType: 'application/json',
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
    );

    return _ApiClient(dio);
  }

  static Dio get getDio {
    final Dio dio = Dio(
      BaseOptions(
        followRedirects: false,
        contentType: 'application/json',
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(alice.getDioInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(alice.getDioInterceptor());
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
    } else {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          request: false,
          error: false,
          logPrint: (object) {
            if (kDebugMode) {
              print(object);
            }
          },
        ),
      );
    }
    // dio.interceptors.add(
    // RetryInterceptor(
    //   dio: dio,
    //   refreshTokenFunction: () async {
    //     await LocalSource().clearProfile();
    //     cancelToken.cancel();
    //   },
    //   toNoInternetPageNavigator: () async {
    //     await Getx.Get.toNamed<void>(AppRoutes.internetConnection);
    //   },
    //   forbiddenFunction: () async {
    //     await Getx.Get.offNamedUntil<void>(AppRoutes.requestAuth, (route) => false);
    //     await LocalSource().clearProfile();
    //     cancelToken.cancel();
    //   },
    // ),
    // );
    return dio;
  }

  static ApiClient? _apiClient;

  static ApiClient getInstance() {
    if (_apiClient != null) {
      return _apiClient!;
    } else {
      _apiClient = ApiClient(getDio);
      return _apiClient!;
    }
  }

  @GET('api/users?page=2')
  Future<GetUsersResponse> getUsers();

  @POST('api/users')
  Future<GetOneUserResponse> postUser(
    @Body() PostUserRequest postUserRequest,
  );
}
