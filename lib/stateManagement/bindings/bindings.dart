import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';

class MusicBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ToolController());
    Get.lazyPut(() => MusicControllers());
  }
}
