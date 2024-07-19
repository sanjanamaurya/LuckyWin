class AboutusModel {
  final int? id;
  final String? name;
  final String? description;


  AboutusModel({
    required this.id,
    required this.name,
    required this.description,

  });

  factory AboutusModel.fromJson(Map<dynamic, dynamic> json) {
    return AboutusModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],

    );
  }
}
