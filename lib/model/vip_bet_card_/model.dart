class VipBetCardModel {
  dynamic id;
  dynamic name;
  dynamic rangeAmount;
  dynamic levelUpRewards;
  dynamic monthlyRewards;
  dynamic rebateRate;
  dynamic status;
  dynamic levelUpStatus;
  dynamic monthlyRewardsStatus;
  dynamic rebateRateStatus;
  dynamic betAmount;
  dynamic percentage;
  dynamic createdAt;
  dynamic updatedAt;

  VipBetCardModel({
    this.id,
    this.name,
    this.rangeAmount,
    this.levelUpRewards,
    this.monthlyRewards,
    this.rebateRate,
    this.status,
    this.levelUpStatus,
    this.monthlyRewardsStatus,
    this.rebateRateStatus,
    this.betAmount,
    this.percentage,
    this.createdAt,
    this.updatedAt,
  });

  VipBetCardModel.fromJson(Map<String, dynamic> json) {
    print(json['percantage']);
    print("jjjjjj");
    id = json['id'];
    name = json['name'];
    rangeAmount = json['range_amount'];
    levelUpRewards = json['level_up_rewards'];
    monthlyRewards = json['monthly_rewards'];
    rebateRate = json['rebate_rate'];
    status = json['status'];
    levelUpStatus = json['level_up_status'];
    monthlyRewardsStatus = json['monthly_rewards_status'];
    rebateRateStatus = json['rebate_rate_status'];
    betAmount = json['bet_amount'];
    percentage = json['percantage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}