class DashboardOverviewModel {
  const DashboardOverviewModel({
    required this.totalStudents,
    required this.includesProvisionedAccounts,
    this.mostSubscribed,
    this.leastSubscribed,
    this.lastUpdatedAt,
  });

  final int totalStudents;
  final bool includesProvisionedAccounts;
  final CourseSubscription? mostSubscribed;
  final CourseSubscription? leastSubscribed;
  final DateTime? lastUpdatedAt;

  bool get hasStudents => totalStudents > 0;

  bool get hasComparisons => mostSubscribed != null && leastSubscribed != null;

  bool get hasDisplayData => hasStudents || hasComparisons;
}

class CourseSubscription {
  const CourseSubscription({required this.title, this.subscribers});

  final String title;
  final int? subscribers;
}
