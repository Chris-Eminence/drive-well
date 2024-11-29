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
}
