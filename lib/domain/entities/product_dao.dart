import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';

class ProductDao {
  final String imagePath;
  final String name;
  final String subtitle;
  final String status;
  final String description;
  final List<String> keyPoints;

  ProductDao(this.imagePath, this.name, this.subtitle, this.status, this.description, this.keyPoints);

  factory ProductDao.fromJson(json){
    return ProductDao(
      json['image'],
      json['name'],
      json['subtitle'],
      json['status'],
      json['description'],
      json['keyPoints'].cast<String>(),
    );
  }

  Color getStatusContainerColor(String dataStatus) {
    return (dataStatus == Constants.popular_camel_case)
        ? const Color(0xFFFFE166)
        : const Color(0xFFEBFFED);
  }

  Color getStatusTextColor(String dataStatus) {
    return (dataStatus == Constants.popular_camel_case)
        ? const Color(0xFFC99700)
        : const Color(0xFF006E0A);
  }
}
