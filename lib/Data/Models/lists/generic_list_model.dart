class GenericListModel {
  final int id;
  String? name;
  String? name_ar;
  String? text;
  int? is_packaging;
  String? commission_percentage;

  GenericListModel(
      {required this.id,
      this.name,
      this.name_ar,
      this.text,
      this.commission_percentage,
      this.is_packaging});

  // Factory method to create an instance from JSON
  factory GenericListModel.fromJson(Map<String, dynamic> json) {
    return GenericListModel(
      id: json['id'],
      commission_percentage: json['commission_percentage'],
      name: json['name'],
      is_packaging: json['is_packaging'],
      text: json['text'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commission_percentage': commission_percentage,
      'is_packaging': is_packaging,
      'name': name,
      'text': text,
    };
  }
}

// Function to parse a list of JSON objects into a list of LocationModel instances
List<GenericListModel> parseAuthList(List<dynamic> jsonList) {
  return jsonList.map((json) => GenericListModel.fromJson(json)).toList();
}

T findModelById<T extends GenericListModel>(List<T> list, int id) {
  try {
    return list.firstWhere(
      (model) => model.id == id,
      orElse: () => throw Exception('Model with id $id not found'),
    );
  } catch (e) {
    throw Exception('Error: $e');
  }
}
