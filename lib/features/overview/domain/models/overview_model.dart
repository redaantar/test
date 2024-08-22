import 'observation_chart_model.dart';
import 'progress_chart_model.dart';
import 'status_summary_model.dart';

class OverViewModel {
  final ProgressChartModel progressChart;
  final StatusSummaryModel statusSummary;
  final ObservationsChartModel observationsChart;

  OverViewModel({
    required this.progressChart,
    required this.statusSummary,
    required this.observationsChart,
  });

  factory OverViewModel.fromJson(Map<String, dynamic> json) {
    return OverViewModel(
      progressChart: ProgressChartModel.fromJson(json['progressChart']),
      statusSummary: StatusSummaryModel.fromJson(json['statusSummary']),
      observationsChart: ObservationsChartModel.fromJson(json['observationsChart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'progressChart': progressChart.toJson(),
      'statusSummary': statusSummary.toJson(),
      'observationsChart': observationsChart.toJson(),
    };
  }
}