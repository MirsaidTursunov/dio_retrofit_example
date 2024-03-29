import 'package:dio/dio.dart' hide Headers;


final class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = '';

  ServerError.withDioError({required DioException error}) {
    _handleError(error);
  }

  ServerError.withError({
    required String message,
    int? code,
  }) {
    _errorMessage = message;
    _errorCode = code;
  }

  int get errorCode => _errorCode ?? 0;

  String get message => _errorMessage;

  void _handleError(DioException error) {
    _errorCode = error.response?.statusCode ?? 500;
    if (_errorCode == 500) {
      _errorMessage = 'Server error';
      return;
    }
    if (_errorCode == 502) {
      _errorMessage = 'Server down';
      return;
    }
    if (_errorCode == 404) {
      _errorMessage = 'Not Found';
      return;
    }
    if (_errorCode == 413) {
      _errorMessage = 'Request Entity Too Large';
      return;
    }
    if (_errorCode == 401) {
      _errorMessage = 'Token expired';
      return;
    }
    if (_errorCode == 403) {
      _errorMessage = 'Token expired';
      return;
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.badResponse:
        {
          if (error.response?.data['Error'] is Map<String, dynamic>) {
            _errorMessage = error.response!.data['Error']['message'].toString();
          } else {
            _errorMessage = error.response!.data['message'].toString();
          }
          break;
        }
      case DioExceptionType.cancel:
        _errorMessage = 'Canceled';
        break;
      case DioExceptionType.unknown:
        _errorMessage = 'Something wrong';
        break;
      case DioExceptionType.badCertificate:
        _errorMessage = 'Bad certificate';
        break;
      case DioExceptionType.connectionError:
        _errorMessage = 'Connection error';
        break;
    }
    return;
  }
}

class ServerException implements Exception {
  ServerException({required this.message});

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(message: json['data']);
  final String message;
}
