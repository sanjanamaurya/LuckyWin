



class ActivityCollectionBonusModel {
  dynamic id;
  dynamic userid;
  dynamic amount;
  dynamic subtypeId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic description;

  ActivityCollectionBonusModel(
  {
    this.id,
  this.userid,
  this.amount,
  this.subtypeId,
  this.createdAt,
  this.updatedAt,
  this.name,
  this.description,
  });

  ActivityCollectionBonusModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  userid = json['userid'];
  amount = json['amount'];
  subtypeId = json['subtypeid'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  name = json['name'];
  description = json['description'];
  }
}
