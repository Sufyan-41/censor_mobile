import 'package:get/get.dart';

import '../modules/compose/bindings/compose_binding.dart';
import '../modules/compose/views/compose_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/outlook_compose/bindings/outlook_compose_binding.dart';
import '../modules/outlook_compose/views/outlook_compose_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.OUTLOOK_COMPOSE;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.COMPOSE,
      page: () => const ComposeView(),
      binding: ComposeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.OUTLOOK_COMPOSE,
      page: () => const OutlookComposeView(),
      binding: OutlookComposeBinding(),
    ),
  ];
}
