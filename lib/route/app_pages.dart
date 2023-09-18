import 'package:get/get.dart';
import 'package:to_do_app/screen/assignment_1/first_screen.dart';
import 'package:to_do_app/screen/assignment_1/third_screen.dart';
import '../screen/assignment_1/secound_screen.dart';
import '../screen/assingment_2/home_screen.dart';
part 'app_route.dart';

class AppPages {
  AppPages._();

  static const home = Routes.Home;
  static const first = Routes.first;
  static const secound = Routes.secound;
  static const third = Routes.third;

  static final routes = [
    GetPage(name: _Paths.Home, page: () => const HomeScreen()),

    //assingment 1 screen
    GetPage(name: _Paths.first, page: () => const FirstScreen()),
    GetPage(name: _Paths.secound, page: () => const SecoundScreen()),
    GetPage(name: _Paths.third, page: () => const ThirdScreen()),

  ];
}
