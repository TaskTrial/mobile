import '../../data/models/auth/login_model.dart' as data;

class LoginModel {
  final String? accessToken;
  final String? refreshToken;
  final UserModel? user;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginModel.fromDataModel(data.LoginModel dataModel) {
    return LoginModel(
      accessToken: dataModel.accessToken,
      refreshToken: dataModel.refreshToken,
      user: dataModel.user != null ? UserModel.fromDataModel(dataModel.user!) : null,
    );
  }

  data.LoginModel toDataModel() {
    return data.LoginModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user?.toDataModel(),
    );
  }

  @override
  String toString() {
    return 'LoginModel{accessToken: $accessToken, refreshToken: $refreshToken, user: $user}';
  }
}