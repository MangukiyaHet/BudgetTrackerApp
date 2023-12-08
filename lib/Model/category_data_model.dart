import 'package:flutter/services.dart';

class CategoryModel {
  int? id;
  String category_name;
  Uint8List category_image;

  CategoryModel({
    this.id,
    required this.category_name,
    required this.category_image,
  });

  factory CategoryModel.fromSQL({required Map data}) {
    return CategoryModel(
      id: data['id'],
      category_name: data['category_name'],
      category_image: data['category_image'],
    );

  }
}
