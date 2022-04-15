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
  String access_token;
  String token_type;

  Token({required this.access_token, required this.token_type});

  static Token fromJson(Map<String, dynamic> body) => Token(
      access_token: body["access_token"] as String,
      token_type: body["token_type"] as String
  );
}