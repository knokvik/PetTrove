class Pet {
  final String id;
  final String name;
  final int vaccinationCount;
  final int checkupCount;
  final int exerciseCount;
  final int feedingCount;

  Pet({
    required this.id,
    required this.name,
    required this.vaccinationCount,
    required this.checkupCount,
    required this.exerciseCount,
    required this.feedingCount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'vaccinationCount': vaccinationCount,
        'checkupCount': checkupCount,
        'exerciseCount': exerciseCount,
        'feedingCount': feedingCount,
      };
}
