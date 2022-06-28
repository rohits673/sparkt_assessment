class User {
  final String firstName;
  final String lastName;
  final String avatar;

  const User({
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar'],
      );
}
