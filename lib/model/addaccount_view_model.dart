class AddacountViewModel {

  dynamic id;
  dynamic name;
  dynamic accountNumber;
  dynamic branch;
  dynamic bankName;
  dynamic ifscCode;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userId;

  AddacountViewModel(
  {this.id,
  this.name,
  this.accountNumber,
  this.branch,
  this.bankName,
  this.ifscCode,
  this.status,
  this.createdAt,
  this.updatedAt,
  this.userId});

  AddacountViewModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  accountNumber = json['account_number'];
  branch = json['branch'];
  bankName = json['bank_name'];
  ifscCode = json['ifsc_code'];
  status = json['status'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  userId = json['user_id'];
  }

  }