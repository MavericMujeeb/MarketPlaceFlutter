import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';

class ProductIntegrationController extends BaseController{
  ProductIntegrationController(super.repo);

  Future integrateApp() async {
    return Future.delayed(const Duration(seconds: 3));
  }
}