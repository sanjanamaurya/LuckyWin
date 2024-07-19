class ExtraDepositModel {
  dynamic id;
  dynamic firstDepositAmount;
  dynamic bonus;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  ExtraDepositModel(
  {this.id,
  this.firstDepositAmount,
  this.bonus,
  this.status,
  this.createdAt,
  this.updatedAt});
  ExtraDepositModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  firstDepositAmount = json['first_deposit_ammount'];
  bonus = json['bonus'];
  status = json['status'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  }
}