import 'package:dartz/dartz.dart';

import '../../../../core/common/failures.dart';
import '../models/overview_model.dart';

abstract class OverViewRepository {
  Future<Either<Failure, OverViewModel>> getOverview();
}