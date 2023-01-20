import 'dart:convert';
import 'dart:io';
import 'package:marketplace/domain/entities/product_dao.dart';
import 'package:marketplace/domain/repositories/dashboard_repository.dart';

class DataDashboardRepository implements DashboardRepository {
  DataDashboardRepository._privateConstructor();

  /// Singleton object of `DataAuthenticationRepository`
  static final DataDashboardRepository _instance = DataDashboardRepository._privateConstructor();

  factory DataDashboardRepository() => _instance;

  List products = [];
  List appCategories = [];
  List newApps = [];
  
  Future getJson() async {
    //Load from assets
    final file = File('/Users/balajibm/Workspace/Citi Marketplace/market_place/products.json');
    final content = await file.readAsString();
    return jsonDecode(content);
  }

  createProductEntities(Map json){
    json.forEach((category, productList) {
      appCategories.add(category);
      for(var product in products){
        ProductDao dao = ProductDao.fromJson(product);
        if(dao.status == 'new'){
          newApps.add(dao);
        }
        else{
          products.add(dao);
        }
      }
    });
  }

  @override
  fetchProducts() async {
    var productsJson = await getJson();
    createProductEntities(productsJson);
  }

}
