class ProductModelFields {
  static const String id = "_id";
  static const String name = "name";
  static const String count = "count";
  static const String barcode = "barcode";

  static const String dbTable = "products";
}

class ProductModel {
  int? id;
  final String name;
  final String count;
  final String barcode;

  ProductModel({
    this.id,
    required this.name,
    required this.count,
    required this.barcode,
  });

  ProductModel copyWith({
    String? name,
    String? count,
    String? barcode,
    int? id,
  }) {
    return ProductModel(
      count: count ?? this.count,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      id: id ?? this.id,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      count: json[ProductModelFields.count] ?? "",
      name: json[ProductModelFields.name] ?? "",
      barcode: json[ProductModelFields.barcode] ?? "",
      id: json[ProductModelFields.id] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ProductModelFields.count: count,
      ProductModelFields.name: name,
      ProductModelFields.barcode: barcode,
    };
  }

  @override
  String toString() {
    return '''
      name: $name
      count: $count 
      barcode: $barcode 
      id: $id, 
    ''';
  }
}
