import 'package:flutter/material.dart';
import '../../../../core/common/usecase.dart';
import '../../domain/models/overview_model.dart';
import '../../domain/usecase/get_overview_usecase.dart';

class OverviewProvider extends ChangeNotifier {
  final getOverViewUseCase = GetOverViewUseCase();

  OverViewModel? _overview;
  OverViewModel? get overview => _overview;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  Future<void> getOverview() async {
    _isLoading = true;
    notifyListeners();
    final result = await getOverViewUseCase.call(NoParams());
    result.fold(
      (left) {
        _isError = true;
        _isLoading = false;
        notifyListeners();
      }, (right) {
        _overview = right;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}