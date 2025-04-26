import 'package:ecommerce/features/home/data/models/banner_model.dart';

class BannerListModel {
  String? msg;
  List<BannerModel>? categoryList;

  BannerListModel({this.msg, this.categoryList});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categoryList = <BannerModel>[];
      json['data'].forEach((v) {
        categoryList!.add(BannerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (categoryList != null) {
      data['data'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

