import 'package:equatable/equatable.dart';

class ProductDetailsModel extends Equatable {
  const ProductDetailsModel({
    required this.productId,
    required this.productName,
    required this.description,
    required this.mrp,
    required this.sellingPrice,
    required this.discountPercentage,
    required this.averageRating,
    required this.ratingCount,
    required this.productImages,
  });

  final String? productId;
  final String? productName;
  final String? description;
  final int? mrp;
  final int? sellingPrice;
  final int? discountPercentage;
  final double? averageRating;
  final int? ratingCount;
  final List<String> productImages;

  ProductDetailsModel copyWith({
    String? productId,
    String? productName,
    String? description,
    int? mrp,
    int? sellingPrice,
    int? discountPercentage,
    double? averageRating,
    int? ratingCount,
    List<String>? productImages,
  }) {
    return ProductDetailsModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      averageRating: averageRating ?? this.averageRating,
      ratingCount: ratingCount ?? this.ratingCount,
      productImages: productImages ?? this.productImages,
    );
  }

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      productId: json["product_id"],
      productName: json["product_name"],
      description: json["description"],
      mrp: json["mrp"],
      sellingPrice: json["selling_price"],
      discountPercentage: json["discount_percentage"],
      averageRating: json["average_rating"],
      ratingCount: json["rating_count"],
      productImages: json["product_images"] == null
          ? []
          : List<String>.from(json["product_images"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "description": description,
    "mrp": mrp,
    "selling_price": sellingPrice,
    "discount_percentage": discountPercentage,
    "average_rating": averageRating,
    "rating_count": ratingCount,
    "product_images": productImages.map((x) => x).toList(),
  };

  @override
  List<Object?> get props => [
    productId,
    productName,
    description,
    mrp,
    sellingPrice,
    discountPercentage,
    averageRating,
    ratingCount,
    productImages,
  ];
}
