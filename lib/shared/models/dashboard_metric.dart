class DashboardMetric {
  final String title;
  final String value;
  final String change;
  final String iconName; // Optional: name of icon as string

  DashboardMetric({
    required this.title,
    required this.value,
    required this.change,
    required this.iconName,
  });
}
