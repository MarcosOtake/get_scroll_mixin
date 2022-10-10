import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';

import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController
    with StateMixin<List<UserModel>>, ScrollMixin {
  final UserRepository _userRepository;
  UserListController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final _page = 1.obs;
  final limit = 20;
  late final Worker workerPage;
  final _loading = false.obs;
  bool get isloading => _loading.value;

  @override
  void onInit() {
    workerPage = ever<int>(_page, (_) {
      _findUser();
    });
    super.onInit();
  }

  @override
  void onReady() {
    _findUser();
    super.onReady();
  }

  @override
  void onClose() {
    workerPage();
    super.onClose();
  }

  void findPages() => _page.value++;

  Future _findUser() async {
    _loading(true);
    final result =
        await _userRepository.getUsers(page: _page.value, limit: limit);
    final stateResult = state ?? [];
    stateResult.addAll(result);
    change(stateResult, status: RxStatus.success());
    _loading(false);
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  Future<void> onEndScroll() async {
    if (!isloading) {
      _page.value++;
    }
  }
}
