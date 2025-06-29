class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    fullName: json['full_name'],
    avatarUrl: json['avatar_url'],
  );
}
