// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<CartDataModel> data;
  final String msg;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    status: json["status"],
    data: List<CartDataModel>.from(json["data"].map((x) => CartDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class CartDataModel {
  CartDataModel({
    required this.cartId,
    required this.createdAt,
    required this.amount,
    required this.isActive,
    required this.batchDetails,
  });

  final String cartId;
  final DateTime createdAt;
  final String amount;
  final bool isActive;
  final dynamic batchDetails;

  factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
    cartId: json["cart_id"],
    createdAt: DateTime.parse(json["created_at"]),
    amount: json["Amount"],
    isActive: json["is_active"],
    batchDetails: json["batchDetails"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId,
    "created_at": createdAt.toIso8601String(),
    "Amount": amount,
    "is_active": isActive,
    "batchDetails": batchDetails,
  };
}
