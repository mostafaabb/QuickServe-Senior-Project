class Rating {
  final int? userId;
  final int rating;
  final String? comment;

  Rating({
    this.userId,
    required this.rating,
    this.comment,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
      rating: json['rating'] != null
          ? int.tryParse(json['rating'].toString()) ?? 0
          : 0,
      comment: json['comment']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'rating': rating,
      'comment': comment,
    };
  }

  @override
  String toString() => 'Rating(userId: $userId, rating: $rating, comment: "$comment")';
}
