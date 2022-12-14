import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/bindings/user_bindings.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';
import 'package:get_scroll_mixin/pages/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Get Scroll Mixin',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // initialBinding: BindingsBuilder(() {
      //   // Get.lazyPut(
      //   //   () => Dio(
      //   //     BaseOptions(baseUrl: 'http://192.168.15.7:8080/'),
      //   //   ),
      //   //   fenix: true,
      //   // );
      //   // Get.lazyPut(
      //   //   () => UserRepository(
      //   //     dio: Get.find(),
      //   //   ),
      //   //   fenix: true,
      //   // );
      // }),
      getPages: [
        GetPage(
          name: '/',
          bindings: [
            UserBindings(),
            BindingsBuilder.put(
                () => UserListController(userRepository: Get.find())),
          ],
          page: () => UserListPage(),
        ),
      ],
    );
  }
}
