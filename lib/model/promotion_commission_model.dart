class CommissionDetailModel {
  dynamic numberOfBettors;
  dynamic betAmount;
  dynamic commissionPayout;
  dynamic date;
  dynamic settlementDate;

  CommissionDetailModel(
      {
        this.numberOfBettors,
        this.betAmount,
        this.commissionPayout,
        this.date,
        this.settlementDate
      });

  CommissionDetailModel.fromJson(Map<String, dynamic> json) {
    numberOfBettors = json['number_of_bettors'];
    betAmount = json['bet_amount'];
    commissionPayout = json['commission_payout'];
    date = json['date'];
    settlementDate = json['settlement_date'];
  }
}