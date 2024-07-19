class TransctionTypeModel {
  dynamic id;
  dynamic name;

  TransctionTypeModel({this.id, this.name});

  TransctionTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}