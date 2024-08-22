import 'package:flutter/material.dart';

class ProgressChartItemModel {
  final String status;
  final String color;
  final int value;

  ProgressChartItemModel({
    required this.status,
    required this.color,
    required this.value,
  });

  factory ProgressChartItemModel.fromJson(Map<String, dynamic> json) {
    return ProgressChartItemModel(
      status: json['status'] as String,
      color: json['color'] as String,
      value: json['value'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'color': color,
      'value': value,
    };
  }

  Color get colorValue {
    switch (status) {
      case 'Pending':
        return Colors.pinkAccent;
      case 'Progress':
        return Colors.orange;
      case 'Resolved':
        return Colors.green;
      case 'Closed':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}

class ProgressChartModel {
  final String title;
  final String subtitle;
  final List<ProgressChartItemModel> data;

  ProgressChartModel({
    required this.title,
    required this.subtitle,
    required this.data,
  });

  factory ProgressChartModel.fromJson(Map<String, dynamic> json) {
    return ProgressChartModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => ProgressChartItemModel.fromJson(item))
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