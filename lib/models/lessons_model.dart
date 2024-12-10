class LessonsModel {
  final int amount;
  final String? courseId;
  final String duration;
  final String description;
  final String? shortDescription; // New field for the short description
  final String imageUrl;
  final String lessonName;

  LessonsModel({
    required this.amount,
    this.courseId,
    required this.duration,
    required this.description,
    this.shortDescription, // Include the short description in the constructor
    required this.imageUrl,
    required this.lessonName,
  });

  // Convert a JSON map into a LessonsModel object
  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    return LessonsModel(
      amount: json['amount'],
      courseId: json['course_id'],
      duration: json['duration'],
      description: json['description'],
      shortDescription: json['short_description'], // Parse the short description from JSON
      imageUrl: json['image_url'],
      lessonName: json['lesson_name'],
    );
  }

  // Convert a LessonsModel object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'course_id': courseId,
      'duration': duration,
      'description': description,
      'short_description': shortDescription, // Add the short description to the JSON map
      'image_url': imageUrl,
      'lesson_name': lessonName,
    };
  }
}
