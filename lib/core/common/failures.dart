import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ClientFailure extends Failure {
  final String error;
  ClientFailure({required this.error});
}

class ServerFailure extends Failure {}

class UnknownFailure extends Failure {}