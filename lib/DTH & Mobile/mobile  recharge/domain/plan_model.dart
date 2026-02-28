class PlanTab {
  final String id;
  final String title;
  final List<PlanDetail> plans;

  PlanTab({required this.id, required this.title, required this.plans});

  factory PlanTab.fromJson(Map<String, dynamic> json) {
    var plansList = json['plans'] as List? ?? [];
    List<PlanDetail> planDetailsList = plansList
        .map((i) => PlanDetail.fromJson(i))
        .toList();

    return PlanTab(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      plans: planDetailsList,
    );
  }
}

class PlanDetail {
  final String id;
  final String amt;
  final String validity;
  final String descr;

  PlanDetail({
    required this.id,
    required this.amt,
    required this.validity,
    required this.descr,
  });

  factory PlanDetail.fromJson(Map<String, dynamic> json) {
    return PlanDetail(
      id: json['id']?.toString() ?? '',
      amt: json['amt']?.toString() ?? '',
      validity: json['validity']?.toString() ?? '',
      descr: json['descr']?.toString() ?? '',
    );
  }
}
