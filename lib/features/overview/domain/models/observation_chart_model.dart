class ObservationDataPoint {
  final int day;
  final int count;

  ObservationDataPoint({
    required this.day,
    required this.count,
  });

  factory ObservationDataPoint.fromJson(Map<String, dynamic> json) {
    return ObservationDataPoint(
      day: json['day'] as int,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'count': count,
    };
  }
}

class ObservationsChartModel {
  final String title;
  final String subtitle;
  final List<ObservationDataPoint> data;

  ObservationsChartModel({
    required this.title,
    required this.subtitle,
    required this.data,
  });

  factory ObservationsChartModel.fromJson(Map<String, dynamic> json) {
    return ObservationsChartModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => ObservationDataPoint.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}