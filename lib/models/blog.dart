
class Blog {
  final String userId;
  final String name;
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;

  Blog({
    required this.userId,
    required this.name,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
  });

  // Convert Blog to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name' : name,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'date': date.toIso8601String(),
    };
  }

  // Create Blog from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      userId: json['userId'],
      name : json['name'],
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
      date: DateTime.parse(json['date']),
    );
  }
}
