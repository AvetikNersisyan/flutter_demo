// user model that should be stored ( persist in local storage );
class User {
  late String id;

  late String username;

  late String email;

  late String passwordHash;

  User({
  required this.id,
    required this.username,
    required this.email,
    required this.passwordHash
});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'passwordHash': passwordHash,
  };



}