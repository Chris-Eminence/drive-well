class Payment {
  final String email;
  final int amount;
  final int hours;
  final int? courseId;
  final String duration;

  Payment({
    required this.email,
    required this.amount,
    required this.hours,
    this.courseId,
    required this.duration,
  });

  // Factory constructor for creating a Payment object from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      email: json['email'] as String,
      amount: json['amount'] as int,
      hours: json['hours'] as int,
      courseId: json['course_id'] ,
      duration: json['duration'] as String,
    );
  }

  // Method to convert a Payment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'amount': amount,
      'hours': hours,
      'course_id': courseId,
      'duration': duration,
    };
  }
}
