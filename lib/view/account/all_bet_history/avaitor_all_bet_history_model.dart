class AvaitorHistoryModel {
  dynamic id;
  dynamic uid;
  dynamic amount;
  dynamic stopMultiplier;
  dynamic gameId;
  dynamic totalamount;
  dynamic number;
  dynamic subNumber;
  dynamic color;
  dynamic gameSrNum;
  dynamic commission;
  dynamic status;
  dynamic resultStatus;
  dynamic win;
  dynamic multiplier;
  dynamic datetime;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic cashoutAmount;
  dynamic crashPoint;

  AvaitorHistoryModel(
      {this.id,
        this.uid,
        this.amount,
        this.stopMultiplier,
        this.gameId,
        this.totalamount,
        this.number,
        this.subNumber,
        this.color,
        this.gameSrNum,
        this.commission,
        this.status,
        this.resultStatus,
        this.win,
        this.multiplier,
        this.datetime,
        this.createdAt,
        this.updatedAt,
        this.cashoutAmount,
        this.crashPoint,
      });

  AvaitorHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    amount = json['amount'];
    stopMultiplier = json['stop_multiplier'];
    gameId = json['game_id'];
    totalamount = json['totalamount'];
    number = json['number'];
    subNumber = json['sub_number'];
    color = json['color'];
    gameSrNum = json['game_sr_num'];
    commission = json['commission'];
    status = json['status'];
    resultStatus = json['result_status'];
    win = json['win'];
    multiplier = json['multiplier'];
    datetime = json['datetime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cashoutAmount = json['cashout_amount'];
    crashPoint = json['crash_point'];
  }

}