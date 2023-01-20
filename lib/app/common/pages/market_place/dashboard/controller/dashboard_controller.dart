import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/presenter/dashboard_presenter.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

class DashboardController extends BaseController {
  final DashboardPresenter _dashboardPresenter;

  DashboardController(super.repo)
      : _dashboardPresenter = DashboardPresenter(repo);

  loadProducts () async {
    await _dashboardPresenter.fetchProducts();
  }

  Future <List<ProductDao>> performSearch (pattern) async{
    if("addepar".contains(pattern.toString().toLowerCase())){
      return [
        ProductDao.fromJson( {
          'image':Resources.addepar_img,
          'name':'Addepar',
          'subtitle':'#2 in Wealth',
          'status': 'Popular',
          'description':'',
          'keyPoints':[],
        })
      ];
    }
    else{
      return [];
    }
  }
}
