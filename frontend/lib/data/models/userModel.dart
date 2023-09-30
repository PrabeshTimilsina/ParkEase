class User {
  String name;
  String email;
  String password;
  ProfileImage profileImage;
  String role;
  String resetPasswordToken;
  DateTime? resetPasswordExpire;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.profileImage,
    this.role = "user",
    this.resetPasswordToken = "",
    required this.resetPasswordExpire,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      profileImage: ProfileImage.fromJson(json['profile_image']),
      role: json['role'] ?? "user",
      resetPasswordToken: json['resetPasswordToken'] ?? "",
      resetPasswordExpire: json['resetPasswordExpire'] != null
          ? DateTime.parse(json['resetPasswordExpire'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profile_image': profileImage.toJson(),
      'role': role,
      'resetPasswordToken': resetPasswordToken,
      'resetPasswordExpire': resetPasswordExpire != null
          ? resetPasswordExpire!.toIso8601String()
          : null,
    };
  }
}

class ProfileImage {
  String publicId;
  String url;

  ProfileImage({
    required this.publicId,
    required this.url,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      publicId: json['public_id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }
}
