class User{
  String username;
  String password;

  User({required this.username, required this.password});

  static fromJson(Map<String, dynamic> map) => User(
      username: map["username"] as String,
      password: map["password"] as String
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password
  };
}

class Token{
  String accessToken;
  String tokenType;
  String username;

  Token({required this.accessToken, required this.tokenType, required this.username});

  static Token fromJson(Map<String, dynamic> body) => Token(
      accessToken: body["access_token"] as String,
      tokenType: body["token_type"] as String,
      username: body["username"] as String
  );
}