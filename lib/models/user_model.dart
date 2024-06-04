class UserModel {
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String image;
  final String bio;
  final String cover;
  final bool isEmailVerified;

  UserModel(
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.bio,
    this.cover,
  );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['name'],
      json['email'],
      json['phone'],
      json['uId'],
      json['isEmailVerified'],
      json['image'],
      json['bio'],
      json['cover'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'bio': bio,
      'cover': cover,
    };
  }
}
