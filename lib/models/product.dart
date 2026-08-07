class Product {
 int id;
 String title;
 String description;
 String category;
 String image;
 double price;
 double rating;
 int ratingCount;
 Product({
  required this.id,
  required this.title,
  required this.description,
  required this.category,
  required this.image,
  required this.price,
  required this.rating,
  required this.ratingCount,
 });
 factory Product.fromJson(Map<String, dynamic> json){
  return Product(
   id: json["id"],
   title: json["title"],
   category: json["category"],
   description: json["description"],
   image: json["image"],
   price: (json["price"] as num).toDouble(),
   rating: (json["rating"]["rate"] as num).toDouble(),
   ratingCount: json["rating"]['count'],
  );
 }
}
