class BettingRebateModel {
  dynamic rebateAmount;
  dynamic rebateRate;
  dynamic bettingRebate;
  dynamic datetime;

  BettingRebateModel({this.rebateAmount, this.rebateRate, this.bettingRebate});

  BettingRebateModel.fromJson(Map<String, dynamic> json) {
    rebateAmount = json['rebate_amount'];
    rebateRate = json['rebate_rate'];
    bettingRebate = json['betting_rebate'];
    datetime = json['datetime'];
  }
  
}
