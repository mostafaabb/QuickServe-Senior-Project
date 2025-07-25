class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,       // nullable
      address: json['address'] as String?,   // nullable
      avatar: json['avatar'] as String?,     // nullable
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'email': email,
    };
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address;
    if (avatar != null) data['avatar'] = avatar;
    return data;
  }
}
