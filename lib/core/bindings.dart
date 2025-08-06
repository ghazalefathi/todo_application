import 'package:get/get.dart';
import 'package:todo_application/controller/main_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
   Get.put(MainController());
  }
}
