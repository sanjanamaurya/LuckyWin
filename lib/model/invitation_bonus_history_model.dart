


class InvitationBonusHistoryModel {

  dynamic username;
  dynamic uId;
  dynamic firstRechargeAmount;
  dynamic createdAt;

  InvitationBonusHistoryModel({this.username, this.uId, this.firstRechargeAmount, this.createdAt});

  InvitationBonusHistoryModel.fromJson(Map<String, dynamic> json) {
  username = json['username'];
  uId = json['u_id'];
  firstRechargeAmount = json['first_recharge_amount'];
  createdAt = json['created_at'];
  }
}
