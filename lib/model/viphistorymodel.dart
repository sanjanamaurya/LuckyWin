class VipHistoryModel{
  dynamic exp;
  dynamic createdAt;

  VipHistoryModel({
    this.exp,
    this.createdAt,
  });

  factory VipHistoryModel.fromJson(Map<dynamic, dynamic>json){
    return VipHistoryModel(
      exp: json["exp"],
      createdAt: json["created_at"],
    );
  }
}