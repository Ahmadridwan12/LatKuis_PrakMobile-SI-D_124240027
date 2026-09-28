class Animal {
  const Animal({
    required this.name,
    required this.type,
    required this.weight,
    required this.habitat,
    required this.height,
    required this.activities,
    required this.image,
  });

  final String name;
  final String type;
  final double weight;
  final List<String> habitat;
  final int height;
  final List<String> activities;
  final String image;
}
