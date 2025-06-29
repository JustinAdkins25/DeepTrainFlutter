class ScenarioModel {
  final String id;
  final String title;
  final String domain; // e.g. 'Project Management', 'Healthcare'
  final DateTime createdAt;

  ScenarioModel({
    required this.id,
    required this.title,
    required this.domain,
    required this.createdAt,
  });

  factory ScenarioModel.fromJson(Map<String, dynamic> json) => ScenarioModel(
    id: json['id'],
    title: json['title'],
    domain: json['domain'],
    createdAt: DateTime.parse(json['created_at']),
  );
}
