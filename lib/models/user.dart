class User {
  int? id;
  String? name;
  String? level;
  String? email;
  String? password;
  String? token;

  User({this.id, this.name, this.level, this.email, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      level: json['user']['level'],
      email: json['user']['email'],
      password: json['user']['password'],
      token: json['token'],
    );
  }
}
