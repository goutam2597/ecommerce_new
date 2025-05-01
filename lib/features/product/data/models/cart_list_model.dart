import 'package:ecommerce/features/common/data/models/product_model.dart';

class CartListModel {
  String? msg;
  List<CartData>? data;

  CartListModel({this.msg, this.data});

  factory CartListModel.fromJson(Map<String, dynamic> json) {
    return CartListModel(
      msg: json['msg'],
      data: json['data'] != null
          ? List<CartData>.from(
        json['data'].map((x) => CartData.fromJson(x)),
      )
          : [],
    );
  }
}

class CartData {
  int? id;
  String? email;
  int? productId;
  String? color;
  String? size;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;
  int? quantity;

  CartData({
    this.id,
    this.email,
    this.productId,
    this.color,
    this.size,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.product,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      email: json['email'],
      productId: json['product_id'],
      color: json['color'],
      size: json['size'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      quantity: json['qty'] is int
          ? json['qty']
          : int.tryParse(json['qty']?.toString() ?? '1'),
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }
}
