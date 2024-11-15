class ProductModel{
  final String id;
  final String name;
  final int price;
  final String image;

  ProductModel({required this.id, required this.name, required this.price, required this.image,});

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    String? image,
  }){
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image  
    );
  }
}