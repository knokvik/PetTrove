
class Blog {
  final int id;
  final int userId;
  final String name;
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;

  Blog({
    required this.id,
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
      'id': id,
      'userId': userId,
      'name': name,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'date': date.toIso8601String(),
    };
  }

  // Create Blog from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
      date: DateTime.parse(json['date']),
    );
  }
}
