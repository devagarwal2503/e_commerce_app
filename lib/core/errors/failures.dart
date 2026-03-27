import 'package:e_commerce_app/core/errors/exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode})
    : assert(
        statusCode is String || statusCode is int,
        'StatusCode cannot be a {$statusCode.runtimeType}',
      );

  final String message;
  final dynamic statusCode;

  String get errorMessage =>
      "$statusCode ${statusCode is String ? "" : "Error"} : $message";

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}
