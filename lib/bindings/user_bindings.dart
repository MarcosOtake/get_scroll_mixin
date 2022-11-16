import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => Dio(
        BaseOptions(baseUrl: 'http://192.168.15.7:8080/'),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => UserRepository(
        dio: Get.find(),
      ),
      fenix: true,
    );
  }
}
