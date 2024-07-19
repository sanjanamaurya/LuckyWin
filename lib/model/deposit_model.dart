class DepositModel {
  dynamic cash;
  dynamic type;
  dynamic status;
  dynamic orderId;
  dynamic createdAt;
  dynamic typeimage;
  dynamic usdtAmount;

  DepositModel(
      {this.cash, this.type, this.status, this.orderId, this.createdAt,this.typeimage});

  DepositModel.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
    type = json['type'];
    status = json['status'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    typeimage = json['typeimage'];
    usdtAmount = json['usdt_amount'];
  }

}
