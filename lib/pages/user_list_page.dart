import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';

class UserListPage extends StatelessWidget {
  UserListPage({Key? key}) : super(key: key);
  final controller = Get.find<UserListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('User List'),
        ),
        body: controller.obx((state) {
          final newTotalList = state?.length ?? 0;

          return ListView.builder(
              controller: controller.scroll,
              itemCount: newTotalList + 1,
              itemBuilder: (context, index) {
                // if (index == newTotalList) {
                //   return Obx(() {
                //     return Visibility(
                //         visible: controller.isloading,
                //         child: const Padding(
                //           padding: EdgeInsets.only(bottom: 24.0),
                //           child: Center(
                //               child: Text(
                //             'Buscanco usuários...',
                //             style: TextStyle(
                //               fontSize: 16,
                //               color: Colors.blue,
                //             ),
                //           )),
                //         ));
                //   });
                // }
                if (index == newTotalList) {
                  return Obx(() {
                    return Visibility(
                      visible: controller.isloading,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 24.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        )),
                      ),
                    );
                  });
                }
                final user = state?[index];
                return ListTile(
                  trailing: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      const Icon(Icons.numbers_sharp),
                      Text('#: ${user?.id ?? ''}'),
                    ],
                  ),
                  title: Text(user?.name ?? ''),
                  subtitle: Text(user?.email ?? ''),
                );
              });
        }));
  }
}
