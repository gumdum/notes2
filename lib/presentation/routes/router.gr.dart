// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../sign_in/sign_in_page.dart' as _i2;
import '../splash/splash_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SignInRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.SignInPage());
    },
    SplashRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.SplashPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SignInRoute.name, path: '/'),
        _i1.RouteConfig(SplashRoute.name, path: '/splash-page')
      ];
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/');

  static const String name = 'SignInRoute';
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/splash-page');

  static const String name = 'SplashRoute';
}
