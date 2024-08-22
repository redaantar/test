
import 'package:dartz/dartz.dart';

import 'package:test_project/core/common/failures.dart';

import 'package:test_project/features/overview/domain/models/overview_model.dart';

import '../../domain/repository/overview_repository.dart';
import '../data_source/overview_remote_datasource.dart';

class OverViewRepositoryImpl extends OverViewRepository {
  final overViewRemoteDatasource = OverViewRemoteDatasource();
  @override
  Future<Either<Failure, OverViewModel>> getOverview() async {
    try {
      final data = await overViewRemoteDatasource.getOverViewData();
      return right(data);
    } catch (e) {
      return left(ServerFailure());
    }
  }

}