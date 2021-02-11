// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

CustomerRevieww reviewFromJson(String str) => CustomerRevieww.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());


class Review {
  Review({
    this.error,
    this.message,
    this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerRevieww> customerReviews;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerRevieww>.from(
            json["customerReviews"].map((x) => CustomerRevieww.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class CustomerRevieww {
  CustomerRevieww({
    this.id,
    this.name,
    this.review,
  });

  String id;
  String name;
  String review;

  factory CustomerRevieww.fromJson(Map<String, dynamic> json) => CustomerRevieww(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
