import 'package:flutter/material.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

class CategoryContentController extends BaseController {

  List<ProductDao> allApps = [];
  List<ProductDao> topWealthAppsList = [];
  List<ProductDao> topTaxSolutionsList = [];
  List<ProductDao> topAccountingAppsList = [];
  List<ProductDao> whatsNewList = [];

  final Map moneyQuotientApp = {
    'image':Resources.money_quotient_img,
    'name':'Money Quotient',
    'subtitle':'#1',
    'status': 'New',
    'description':'',
    'keyPoints':[]
  };

  final Map adepparApp = {
    'image':Resources.addepar_img,
    'name':'Addepar',
    'subtitle':'#2',
    'status': 'Popular',
    'description':'',
    'keyPoints':[]
  };

  final Map advisorMetrixApp = {
    'image':Resources.advisor_metrix_img,
    'name':'Advisor metrix',
    'subtitle':'#3',
    'status': 'New',
    'description':'',
    'keyPoints':[]
  };

  final Map riskalyzeApp = {
    'image':Resources.riskalyze_img,
    'name':'Riskalyze',
    'subtitle':'#4',
    'status': 'Popular',
    'description':'',
    'keyPoints':[]
  };

  final Map koyfinApp = {
    'image':Resources.koyfin_icon_img,
    'name':'Koyfin',
    'subtitle':'#5',
    'status': 'New',
    'description':'',
    'keyPoints':[]
  };

  final Map covisumApp = {
    'image':Resources.covisum_img,
    'name':'Covisum',
    'subtitle':'#6',
    'status': 'Popular',
    'description':'',
    'keyPoints':[]
  };

  final Map blackrockApp = {
    'image':Resources.blackrock_img,
    'name':'Blackrock',
    'subtitle':'#7',
    'status': 'New',
    'description':'',
    'keyPoints':[]
  };



  CategoryContentController(super.repo) {
    allApps = [
      ProductDao.fromJson(covisumApp),
      ProductDao.fromJson(moneyQuotientApp),
      ProductDao.fromJson(advisorMetrixApp),
      ProductDao.fromJson(riskalyzeApp),
      ProductDao.fromJson(blackrockApp),
      ProductDao.fromJson(koyfinApp),
      ProductDao.fromJson(adepparApp),
    ];
    topWealthAppsList = [
      ProductDao.fromJson(advisorMetrixApp),
      ProductDao.fromJson(adepparApp),
      ProductDao.fromJson(moneyQuotientApp),
    ];
    topTaxSolutionsList = [
      ProductDao.fromJson(riskalyzeApp),
      ProductDao.fromJson(koyfinApp),
      ProductDao.fromJson(covisumApp),
    ];
    topAccountingAppsList = [
      ProductDao.fromJson(koyfinApp),
      ProductDao.fromJson(blackrockApp),
    ];
    whatsNewList = [
      ProductDao.fromJson(blackrockApp),
      ProductDao.fromJson(covisumApp),
      ProductDao.fromJson(koyfinApp),
    ];
  }

  Color getStatusTextColor(String dataStatus) {
    return (dataStatus == 'Popular')
        ? const Color(0xFFC99700)
        : const Color(0xFF006E0A);
  }

  Color getStatusContainerColor(String dataStatus) {
    return (dataStatus == 'Popular')
        ? const Color(0xFFFFE166)
        : const Color(0xFFEBFFED);
  }

  @override
  dataOnNext(data) {
    debugPrint('CategoryContentController dataOnNext =====:');
    return super.dataOnNext(data);
  }
}
