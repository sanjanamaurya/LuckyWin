class TcModel {
  final String? name;
  final String? description;


  TcModel({
    required this.name,
    required this.description,

  });

  factory TcModel.fromJson(Map<dynamic, dynamic> json) {
    return TcModel(
      name: json['name'],
      description: json['description'],

    );
  }
}
