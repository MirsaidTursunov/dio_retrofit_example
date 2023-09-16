import 'package:flutter/material.dart';

sealed class Constants {
  Constants._();
  static const baseUrl = 'https://reqres.in/';
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}

