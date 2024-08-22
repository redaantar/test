import 'package:dartz/dartz.dart';
import '../../../../core/common/failures.dart';
import '../../../../core/common/usecase.dart';
import '../../data/repository_impl/overview_repository_impl.dart';
import '../models/overview_model.dart';
import '../repository/overview_repository.dart';

class GetOverViewUseCase implements UseCase<OverViewModel?, NoParams> {
  final OverViewRepository authRepository = OverViewRepositoryImpl();

  @override
  Future<Either<Failure, OverViewModel?>> call(NoParams params) async {
    return await authRepository.getOverview();
  }
}
