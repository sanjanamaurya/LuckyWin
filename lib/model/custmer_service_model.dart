class CustomerServiceModel {
  String? name;
  String? image;
  String? link;

  CustomerServiceModel({this.name, this.image, this.link});

  CustomerServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['Image'];
    link = json['link'];
  }
}
