class USDTDepositModel {
  final String? actual_amount;
  final String? amount;
  final String? created_at;
  final String? id;
  final String? status;


  USDTDepositModel({
    required this.actual_amount,
    required this.amount,
    required this.created_at,
    required this.id,
    required this.status,
  });
  factory USDTDepositModel.fromJson(Map<String, dynamic> json) {
    return USDTDepositModel(
      actual_amount: json['actual_amount'],
      amount: json['amount'],
      created_at: json['created_at'],
      id: json['id'],
      status: json['status'],
    );
  }
}