import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_app_card.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

class SearchPhonePage extends StatelessWidget{

  final List<ProductDao> products;
  Function? detailActionCallBack;
  SearchPhonePage(Key? key, this.products, this.detailActionCallBack):super(key: key);

  Widget get searchTitle => CustomText(
      textName: Constants.search_results, textAlign: TextAlign.center,  fontSize: 18, fontWeight: FontWeight.bold, textColor: AppColor.black_color
  );

  productCards(){
    List appCards = <Widget>[];
    for(ProductDao productDao in products){
      appCards.add(
        Padding(
          padding: const EdgeInsets.only(top:15.0, left:0.0, right:10.0),
          child: SizedBox(
            height: 180,
            child: CustomAppCard(
              key,
              productImagePath: productDao.imagePath,
              productTitle: productDao.name,
              productPopularity: productDao.subtitle,
              productStatus: productDao.status,
              statusColor: productDao.getStatusContainerColor( productDao.status),
              statusTextColor: productDao.getStatusTextColor( productDao.status),
              detailActionCallBack: detailActionCallBack,
            ),
          ),
        )

      );
    }
    return appCards;
  }

  Widget get searchResults => Wrap(
    direction: Axis.horizontal,
    spacing: 10,
    runSpacing: 10,
    children: productCards(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchTitle,
          const SizedBox(height: 20),
          products.isNotEmpty ? searchResults  : const Center(
            child: Text(Constants.no_results),
          )
        ],
      ),
    );
  }
}