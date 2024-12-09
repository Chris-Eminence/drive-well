class PaymentModel {
  final String? emailAddress;
  final String? amount;
  final String? duration;

  // Constructor
  PaymentModel({
    required this.emailAddress,
    required this.amount,
    required this.duration,
  });

  // Factory constructor to create an instance from a JSON map
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      emailAddress: json['emailAddress'] as String?,
      amount: json['amount'] as String?,
      duration: json['duration'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'amount': amount,
      'duration': duration,
    };
  }

  // Optional: Copy with method to create a copy with updated values
  PaymentModel copyWith({
    String? emailAddress,
    String? amount,
    String? duration,
  }) {
    return PaymentModel(
      emailAddress: emailAddress ?? this.emailAddress,
      amount: amount ?? this.amount,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'PaymentModel(emailAddress: $emailAddress, amount: $amount, duration: $duration)';
  }
}
