class RewardModel {
  final int id;
  final int userId;
  final String title;
  final String code;
  final double discountAmount;
  final bool used;
  final DateTime createdAt;

  RewardModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.code,
    required this.discountAmount,
    required this.used,
    required this.createdAt,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      code: json['code'],
      discountAmount: (json['discount_amount'] as num).toDouble(),
      used: json['used'] == 1 || json['used'] == true,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
