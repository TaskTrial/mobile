class LoginModel {
  final String? accessToken;
  final String? refreshToken;
  final UserModel? user;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user?.toJson(),
    };
  }

  @override
  String toString() {
    return 'LoginModel{accessToken: $accessToken, refreshToken: $refreshToken, user: $user}';
  }
}