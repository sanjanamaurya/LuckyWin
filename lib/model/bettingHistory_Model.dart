// ignore_for_file: non_constant_identifier_names

class BettingHistoryModel {
  dynamic id;
  dynamic amount;
  dynamic commission;
  dynamic tradeAmount;
  dynamic winAmount;
  dynamic number;
  dynamic winNumber;
  dynamic gamesno;
  dynamic gameId;
  dynamic userid;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic gameName;
  dynamic name;
  dynamic orderId;

  BettingHistoryModel(
  {this.id,
  this.amount,
  this.commission,
  this.tradeAmount,
  this.winAmount,
  this.number,
  this.winNumber,
  this.gamesno,
  this.gameId,
  this.userid,
  this.status,
  this.createdAt,
  this.updatedAt,
  this.gameName,
  this.name,
  this.orderId,

  });

  BettingHistoryModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  amount = json['amount'];
  commission = json['commission'];
  tradeAmount = json['trade_amount'];
  winAmount = json['win_amount'];
  number = json['number'];
  winNumber = json['win_number'];
  gamesno = json['gamesno'];
  gameId = json['game_id'];
  userid = json['userid'];
  status = json['status'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  gameName = json['game_name'];
  name = json['name'];
  orderId = json['order_id'];
  }


  }