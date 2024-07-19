class SalaryModel {
  dynamic id;
  dynamic userid;
  dynamic amount;
  dynamic subtypeid;
  dynamic description;
  dynamic description2;
  dynamic createdAt;
  dynamic updatedAt;

  SalaryModel(
      {this.id,
        this.userid,
        this.amount,
        this.subtypeid,
        this.description,
        this.description2,
        this.createdAt,
        this.updatedAt});

  SalaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    amount = json['amount'];
    subtypeid = json['subtypeid'];
    description = json['description'];
    description2 = json['description_2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

