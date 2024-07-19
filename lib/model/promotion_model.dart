class CommissionData {
   dynamic directUserCount;
   dynamic indirectUserCount;
   dynamic numOfPayIndirect;
   dynamic numOfPayTeam;
   dynamic payinAmountTeam;
   dynamic noUserDirect;
   dynamic noUserTeam;
   dynamic noOfFirstPayinDirect;
   dynamic noOfFirstPayinTeam;
   dynamic payinAmountDirect;
   dynamic totalUser;
   dynamic totalCommission;
   dynamic userReferCode;
   List<LevelCommission> levelwiseCommission;
   dynamic userId;
   UserData userData;

  CommissionData({
    required this.directUserCount,
    required this.indirectUserCount,
    required this.numOfPayIndirect,
    required this.numOfPayTeam,
    required this.payinAmountTeam,
    required this.noUserDirect,
    required this.noUserTeam,
    required this.noOfFirstPayinDirect,
    required this.noOfFirstPayinTeam,
    required this.payinAmountDirect,
    required this.totalUser,
    required this.totalCommission,
    required this.userReferCode,
    required this.levelwiseCommission,
    required this.userId,
    required this.userData,
  });

  factory CommissionData.fromJson(Map<String, dynamic> json) {
    return CommissionData(
      directUserCount: json['direct_user_count'],
      indirectUserCount: json['indirect_user_count'],
      numOfPayIndirect: json['numofpayindirect'],
      numOfPayTeam: json['numofpayteam'],
      payinAmountTeam: json['payinAmountTeam'],
      noUserDirect: json['noUserDirect'],
      noUserTeam: json['noUserTeam'],
      noOfFirstPayinDirect: json['noOfFristPayinDirect'],
      noOfFirstPayinTeam: json['noOfFristPayinTeam'],
      payinAmountDirect: json['payinAmountDirect'],
      totalUser: json['totaluser'],
      totalCommission: json['totalcommission'],
      userReferCode: json['user_refer_code'],
      levelwiseCommission: List<LevelCommission>.from(json['levelwisecommission'].map((x) => LevelCommission.fromJson(x))),
      userId: json['user_id'],
      userData: UserData.fromJson(json['userdata']),
    );
  }
}

class LevelCommission {
   dynamic count;
   dynamic name;
   dynamic commission;

  LevelCommission({
    required this.count,
    required this.name,
    required this.commission,
  });

  factory LevelCommission.fromJson(Map<String, dynamic> json) {
    return LevelCommission(
      count: json['count'],
      name: json['name'],
      commission: json['commission'],
    );
  }
}

class UserData {
  final Map<String, List<User>> userLevels;

  UserData({required this.userLevels});

  factory UserData.fromJson(Map<String, dynamic> json) {
    Map<String, List<User>> userLevels = {};
    json.forEach((key, value) {
      List<dynamic> usersJson = value;
      userLevels[key] = usersJson.map((userJson) => User.fromJson(userJson)).toList();
    });
    return UserData(userLevels: userLevels);
  }
}

class User {
   dynamic userId;
   dynamic username;
   dynamic turnover;
   dynamic commission;
   dynamic totalPayin;
   dynamic noOfPayin;

  User({
    required this.userId,
    required this.username,
    required this.turnover,
    required this.commission,
    required this.totalPayin,
    required this.noOfPayin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      turnover: json['turnover'],
      commission: json['commission'],
      totalPayin: json['total_payin'],
      noOfPayin: json['no_of_payin'],
    );
  }
}
