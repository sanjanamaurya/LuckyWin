class NewSubordinateModel {
  String? userName;
  String? mobile;
  String? datetime;

  NewSubordinateModel({this.userName, this.mobile, this.datetime});

  NewSubordinateModel.fromJson(Map<String, dynamic> json) {
    userName = json['u_id'];
    mobile = json['mobile'];
    datetime = json['created_at'];
  }
}