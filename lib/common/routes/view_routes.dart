import 'package:flutter/material.dart';
import 'package:login_with_sqllite/model/user_model.dart';
import 'package:login_with_sqllite/screen/login_form.dart';
import 'package:login_with_sqllite/screen/signup_form.dart';
import 'package:login_with_sqllite/screen/update_form.dart';

import '../../screen/afterlogin.dart';

class RoutesApp {
  static const home = '/';
  //declarar aqui uma nova tela
  static const afterLogin = '/afterLogin';
  static const loginSgnup = '/loginSignup';
  static const loginUpdate = '/loginUpdate';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const LoginForm());

      case loginSgnup:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case afterLogin:
        return MaterialPageRoute(
            builder: (context) => AfterLogin(
                  userModel: (arguments as UserModel),
                ),
            settings: settings);

      case loginUpdate:
        if (arguments is UserModel) {
          return MaterialPageRoute(
            // builder: (context) => UdpateUser(arguments),
            builder: (context) => const UpdateUser(),
            settings: settings,
          );
        } else {
          return _errorRoute();
        }

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
