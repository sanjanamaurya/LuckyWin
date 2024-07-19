class UserProfile {
    dynamic status;
    dynamic message;
    dynamic id;
    dynamic mobile;
    dynamic email;
    dynamic username;
    dynamic userimage;
    dynamic uId;
    dynamic mainWallet;
    dynamic thirdPartyWallet;
    dynamic totalWallet;
    dynamic winningAmount;
    dynamic lastLoginTime;



  UserProfile(
      { required this.status,
        required this.message,
        required this.id,
        required this.mobile,
        required this.email,
        required this.username,
        required this.userimage,
        required  this.uId,
        required this.mainWallet,
        required this.thirdPartyWallet,
        required this.totalWallet,
        required this.winningAmount,
        required this.lastLoginTime,
      });

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    mobile = json['mobile'];
    email = json['email'];
    username = json['username'];
    userimage = json['userimage'];
    uId = json['u_id'];
    mainWallet = json['main_wallet'];
    thirdPartyWallet = json['third_party_wallet'];
    totalWallet = json['total_wallet'];
    winningAmount = json['winning_amount'];
    lastLoginTime = json['last_login_time'];
  }
}


