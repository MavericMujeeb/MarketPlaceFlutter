import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

class ACSChatCallingController extends BaseController {
  List<ProductDao> similarApps = [];
  List<String> keyPoints = [];

  ACSChatCallingController(super.repo) {
    similarApps = [
      ProductDao(Resources.money_quotient_img, 'Money Quotient',
          '#1 in wealth', 'New','',[]),
      ProductDao(Resources.advisor_metrix_img, 'Advisor metrix',
          '#2 in wealth', 'Popular','',[]),
      ProductDao(Resources.blackrock_img, 'Black rock', '#3 in wealth', 'New','',[]),
    ];
  }
  ProductDao productAddepar = ProductDao(
      Resources.addaper_icon_img,
      'Addepar',
      'Estimate your customer\'s ability to repay the loans with DN Scoring app',
      'POPULAR',
      'In the world of financial advice, speed, clarity and foresight aren\'t just nice to have,'
          'they\'re a necessity. '
          'Yet tools are insufficient: wealth management firms need more productivity, scale and reach to remain competitive.'
          ' And  client  exceptions are raising, as people demand a more genuine, more human relationship from those they do business with',
      ['A complete view of your clients\' wealth',
        'Portfolio access with ease',
        'Increase operational efficiency',
        'Portfolio Trading and re balancing',
        'Scenario Modeling and Forecasting',
        'Streamlined Billing, Plus Calculation Insights']);


  Color getStatusTextColor(String dataStatus) {

    return (dataStatus == Constants.popular_camel_case)
        ? const Color(0xFFC99700)
        : const Color(0xFF006E0A);
  }

  Color getStatusContainerColor(String dataStatus) {
    return (dataStatus == Constants.popular_camel_case)
        ? const Color(0xFFFFE166)
        : const Color(0xFFEBFFED);
  }
}
