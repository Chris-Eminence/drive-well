// class User {
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? phoneNumber;
//   String? address;
//   bool? subscriptionStatus;
//   String? role;
//   bool? isAdmin;
//   DateTime? updatedAt;
//   DateTime? createdAt;
//   int? id;
//
//   User({
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.phoneNumber,
//     this.address,
//     this.subscriptionStatus,
//     this.role,
//     this.isAdmin,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json['email'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       phoneNumber: json['phone_number'],
//       address: json['address'],
//       subscriptionStatus: json['subscription_status'],
//       role: json['role'],
//       isAdmin: json['is_admin'] == 1,
//       updatedAt: DateTime.parse(json['updated_at']),
//       createdAt: DateTime.parse(json['created_at']),
//       id: json['id'],
//     );
//   }
// }
//
//


class User {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  bool? subscriptionStatus;
  String? role;
  bool? isAdmin;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  User({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.subscriptionStatus,
    this.role,
    this.isAdmin,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      subscriptionStatus: json['subscription_status'],
      role: json['role'],
      isAdmin: json['is_admin'] == 1,
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  /// Creates a new `User` instance with updated fields
  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    bool? subscriptionStatus,
    String? role,
    bool? isAdmin,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) {
    return User(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      role: role ?? this.role,
      isAdmin: isAdmin ?? this.isAdmin,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }
}
