import 'package:auto_route/auto_route.dart';
import 'package:notes2/presentation/sign_in/sign_in_page.dart';
import 'package:notes2/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SignInPage, initial: true),
    AutoRoute(page: SplashPage),
  ],
)
class $AppRouter {}
