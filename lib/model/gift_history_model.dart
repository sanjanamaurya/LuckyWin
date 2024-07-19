class GiftHistoryModel {
   dynamic id;
   dynamic dateTime;
   dynamic amount;

  GiftHistoryModel({
    required this.id,
    required this.dateTime,
    required this.amount,
  });

  factory GiftHistoryModel.fromJson(Map<dynamic, dynamic> json) {
    return GiftHistoryModel(
      id: json['name'],
      dateTime: json['datetime'],
      amount: json['amount'],

    );
  }
}