class PaymentModel {
  final String orderId;
  final String userpaymentOrderId;
  final String paymentId;
  final String description;
  final String mobileNumber;
  final String userName;
  final String userEmail;
  final String Signature;
  final String batchId;
  final String price;
  final String success;

  PaymentModel(
      {required this.orderId,
      required this.userpaymentOrderId,
      required this.paymentId,
      required this.description,
      required this.mobileNumber,
      required this.userName,
      required this.userEmail,
      required this.Signature,
      required this.batchId,
      required this.price,
      required this.success});

  Map<String, dynamic> toJson() => {
        "pay_order_id": orderId,
        "razorpay_order_id": userpaymentOrderId,
        "razorpay_payment_id": paymentId,
        "description": description,
        "mobileNumber": mobileNumber,
        "userName": userName,
        "userEmail": userEmail,
        "razorpay_signature": Signature,
        "batchId": batchId,
        "price": price,
        "success": success,
      };
}
