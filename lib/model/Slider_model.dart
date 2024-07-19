class SliderModel{
  final String? name;
  final String? image;
  final String? activity_image;


  SliderModel({
    this.name,
    this.image,
    this.activity_image,
  });
  factory SliderModel.fromJson(Map<dynamic, dynamic>json){

    return SliderModel(
      name: json["name"],
      image: json["image"],
      activity_image: json["activity_image"],
    );
  }


}
