import 'package:flutter/material.dart';

/// categoryId : "cat1"
/// createdAt : 1625097600000
/// description : "Apple's latest flagship smartphone with A15 Bionic chip."
/// images : {"image1":"https://example.com/iphone13pro_1.jpg","image2":"https://example.com/iphone13pro_2.jpg"}
/// inStock : true
/// name : "iPhone 13 Pro"
/// price : 999.99
/// quantity : 50
/// ratings : {"averageRating":4.7,"totalRatings":120}
/// reviews : {"rev1":{"comment":"Excellent phone, great camera!","rating":5,"timestamp":1626982400000,"userId":"user1"}}
/// specifications : {"color":"Graphite","storage":"128GB"}
/// subCategoryId : "subcat1"
/// tags : ["smartphone","ios","5G"]
/// updatedAt : 1625097600000


class ProductDm {
  ProductDm({
    this.categoryId,
    this.createdAt,
    this.description,
    this.images,
    this.inStock,
    this.name,
    this.price,
    this.quantity,
    this.ratings,
    this.reviews,
    this.specifications,
    this.subCategoryId,
    this.tags,
    this.updatedAt,
  });

  ProductDm.fromJson(dynamic json) {
    var imageMap = Map<String, String>.from(json['images'] ?? {});
    List<Images> imageList = imageMap.entries.map((m) {
      return Images.fromMap(m.key, m.value);
    }).toList();

    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    description = json['description'];
    images = imageList;
    inStock = json['inStock'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    ratings =
    json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;

    // Updated to handle a list of reviews
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((key, value) {
        reviews!.add(Review.fromJson(value));
      });
    }

    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    subCategoryId = json['subCategoryId'];

    // Updated to handle a list of tags
    tags = json['tags'] != null ? List<String>.from(json['tags']) : [];

    updatedAt = json['updatedAt'];
  }

  String? categoryId;
  num? createdAt;
  String? description;
  List<Images>? images;
  bool? inStock;
  String? name;
  num? price;
  num? quantity;
  Ratings? ratings;
  List<Review>? reviews;
  Specifications? specifications;
  String? subCategoryId;
  List<String>? tags;
  num? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['createdAt'] = createdAt;
    map['description'] = description;
    map['images'] = images?.asMap().map((key, value) => MapEntry(value.id, value.images));
    map['inStock'] = inStock;
    map['name'] = name;
    map['price'] = price;
    map['quantity'] = quantity;
    if (ratings != null) {
      map['ratings'] = ratings?.toJson();
    }
    if (reviews != null) {
      map['reviews'] = reviews?.asMap().map((key, value) => MapEntry('rev${key + 1}', value.toJson()));
    }
    if (specifications != null) {
      map['specifications'] = specifications?.toJson();
    }
    map['subCategoryId'] = subCategoryId;
    map['tags'] = tags;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
/// color : "Graphite"
/// storage : "128GB"

class Specifications {
  Specifications({
    this.color,
    this.storage,
  });

  Specifications.fromJson(dynamic json) {
    color = json['color'];
    storage = json['storage'];
  }
  String? color;
  String? storage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = color;
    map['storage'] = storage;
    return map;
  }
}

/// rev1 : {"comment":"Excellent phone, great camera!","rating":5,"timestamp":1626982400000,"userId":"user1"}
// Update the Reviews class to Review
class Review {
  Review({
    this.comment,
    this.rating,
    this.timestamp,
    this.userId,
  });

  Review.fromJson(dynamic json) {
    comment = json['comment'];
    rating = json['rating'];
    timestamp = json['timestamp'];
    userId = json['userId'];
  }
  String? comment;
  num? rating;
  num? timestamp;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['rating'] = rating;
    map['timestamp'] = timestamp;
    map['userId'] = userId;
    return map;
  }
}



/// averageRating : 4.7
/// totalRatings : 120

class Ratings {
  Ratings({
    this.averageRating,
    this.totalRatings,
  });

  Ratings.fromJson(dynamic json) {
    averageRating = json['averageRating'];
    totalRatings = json['totalRatings'];
  }
  num? averageRating;
  num? totalRatings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['averageRating'] = averageRating;
    map['totalRatings'] = totalRatings;
    return map;
  }
}

/// image1 : "https://example.com/iphone13pro_1.jpg"
/// image2 : "https://example.com/iphone13pro_2.jpg"

class Images {
  final String id;
  final String images;

  Images({
    required this.id,
    required this.images,
  });

  // Factory method to create a SubCategory from a Map
  factory Images.fromMap(String id, String images) {
    return Images(
      id: id,
      images: images,
    );
  }

  // Method to convert a SubCategory to a Map
  Map<String, String> toMap() {
    return {
      id: images,
    };
  }
}
