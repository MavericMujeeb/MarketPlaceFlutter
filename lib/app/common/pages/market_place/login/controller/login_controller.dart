import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';

class LoginController extends BaseController{

  bool isPassVisible = true;

  LoginController(super.repo) {}

  updateVisibility() {
    if(isPassVisible) {
      isPassVisible = false;
    } else {
      isPassVisible = true;
    }
    refreshUI();
  }

}