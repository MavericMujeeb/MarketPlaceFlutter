import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/controller/product_details_controller.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/view/phone/product_details_phone_page.dart';
import 'package:marketplace/data/repositories/data_product_repository.dart';


class ProductDetailsPage extends View{
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailsPageState();
  }
}

class ProductDetailsPageState extends ResponsiveViewState<ProductDetailsPage, ProductDetailsController>{

  ProductDetailsPageState() : super(ProductDetailsController(ProductDataRepository()));

  @override
  Widget get desktopView => const ProductDetailsPhonePage();

  @override
  Widget get mobileView => const ProductDetailsPhonePage();

  @override
  Widget get tabletView => const ProductDetailsPhonePage();

  @override
  Widget get watchView => const ProductDetailsPhonePage();

}