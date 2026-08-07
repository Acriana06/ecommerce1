class UserModel {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = json["name"];

    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      firstName: name["firstname"],
      lastName: name["lastname"],
    );
  }
}