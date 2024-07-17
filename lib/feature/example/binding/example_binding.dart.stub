import 'package:cgen/feature/example/controller/example_controller.dart';
import 'package:cgen/feature/example/repository/example_repository.dart';
import 'package:get/get.dart';

class ExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ExampleController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ExampleRepository(),
      tag: (ExampleRepository).toString(),
      fenix: true,
    );
  }
}
