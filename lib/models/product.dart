class Product{
  final String name;
  final double price;
  final String imgUrl;
  final String type; 
  final String description;  

  const Product({
    required this.name, 
    required this.price, 
    required this.imgUrl,
    required this.type,
    required this.description 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      imgUrl: "http://"+json['image_url'],
      type: json['type_name'],
      description: json['description']
    ); 
  }
}