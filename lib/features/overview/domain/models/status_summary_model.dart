import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StatusSummaryItemModel {
  final String icon;
  final int count;
  final String label;

  StatusSummaryItemModel({
    required this.icon,
    required this.count,
    required this.label,
  });

  factory StatusSummaryItemModel.fromJson(Map<String, dynamic> json) {
    return StatusSummaryItemModel(
      icon: json['icon'] as String,
      count: json['count'] as int,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'count': count,
      'label': label,
    };
  }

  IconData get iconData {
    switch (icon) {
      case 'binoculars':
        return Iconsax.eye;
      case 'pause':
        return Iconsax.pause;
      case 'clock':
        return Iconsax.clock;
      case 'checkmark':
        return Iconsax.tick_circle;
      case 'lock':
        return Iconsax.lock;
      default:
        return Iconsax.eye;
    }
  }

  Color get color {
    switch (label) {
      case 'My observations':
        return Colors.blue;
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

class StatusSummaryModel {
  final List<StatusSummaryItemModel> items;

  StatusSummaryModel({required this.items});

  factory StatusSummaryModel.fromJson(List<dynamic> json) {
    return StatusSummaryModel(
      items: json.map((item) => StatusSummaryItemModel.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return items.map((item) => item.toJson()).toList();
  }
}