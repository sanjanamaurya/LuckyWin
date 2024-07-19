class AllTransactionModel {
  dynamic type;
  dynamic amount;
  dynamic datetime;
  AllTransactionModel({this.type, this.amount, this.datetime});

  AllTransactionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
    datetime = json['datetime'];
  }
}