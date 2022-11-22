class OrderIdGeneration {
  bool? status;
  String? keyId;
  String? keySecret;
  String? id;
  String? currency;
  int? amount;
  String? msg;

  OrderIdGeneration(
      {this.status,
      this.keyId,
      this.keySecret,
      this.id,
      this.currency,
      this.amount,
      this.msg});

  OrderIdGeneration.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    keyId = json['key_id'];
    keySecret = json['key_secret'];
    id = json['id'];
    currency = json['currency'];
    amount = json['amount'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['key_id'] = keyId;
    data['key_secret'] = keySecret;
    data['id'] = id;
    data['currency'] = currency;
    data['amount'] = amount;
    data['msg'] = msg;
    return data;
  }
}
