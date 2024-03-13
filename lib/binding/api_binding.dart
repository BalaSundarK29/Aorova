import 'package:get/get.dart';

import '../data/chopper_client.dart';

class APIBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AppChopperClient());
  }

}