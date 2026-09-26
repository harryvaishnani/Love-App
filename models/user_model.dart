class User {
  final String? id;
  final String fullName;
  final String email;
  final String mobile;
  final String dob;
  final String city;
  final String gender;
  final String hobbies;
  bool isFavorite;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.city,
    required this.gender,
    required this.hobbies,
    this.isFavorite = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['fullName'] ?? '',
    email: json['email'] ?? '',
    mobile: json['mobile'] ?? '',
    dob: json['dob'] ?? '',
    city: json['city'] ?? '',
    gender: json['gender'] ?? '',
    hobbies: json['hobbies'] ?? '',
    isFavorite: json['isFavorite'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'mobile': mobile,
    'dob': dob,
    'city': city,
    'gender': gender,
    'hobbies': hobbies,
    'isFavorite': isFavorite,
  };
}
