class ActivityRecordModel {
  dynamic id;
  dynamic name;
  dynamic rangeAmount;
  dynamic amount;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic betAmount;

  ActivityRecordModel(
      {this.id,
        this.name,
        this.rangeAmount,
        this.amount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.betAmount,
      });

  ActivityRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rangeAmount = json['range_amount'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    betAmount = json['bet_amount'];
  }}
