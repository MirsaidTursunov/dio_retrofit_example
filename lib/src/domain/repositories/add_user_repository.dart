import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:for_network/src/data/models/get_one_user_response.dart';
import 'package:for_network/src/domain/network/api_client.dart';
import 'package:for_network/src/domain/network/server_error.dart';

import '../../data/models/post_user_request.dart';

class AddUserRepository {
  Future<GetOneUserResponse> addOneUser(
      {required PostUserRequest postUserRequest}) async {
    dynamic response;
    try {
      response = ApiClient.getInstance().postUser(postUserRequest);
    } on TypeError {
      debugPrint('type error');
      // ignore: avoid_catching_errors
    } on NoSuchMethodError {
      debugPrint('no such method error');
      // ignore: avoid_catches_without_on_clauses
    } catch (error, stacktrace) {
      debugPrint('Exception occurred: $error stacktrace: $stacktrace');
      final exception = ServerError.withDioError(
        error: error as DioException,
      );
    }
    return response;
  }
}
