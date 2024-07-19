class ChangeAvtarModel {
  final String? image;

  ChangeAvtarModel({
    required this.image,
  });

  factory ChangeAvtarModel.fromJson(Map<dynamic, dynamic> json) {
    return ChangeAvtarModel(
      image: json['image'],
    );
  }
}
