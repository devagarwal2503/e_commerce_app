import 'package:e_commerce_app/core/utils/typedefs.dart';

abstract class UsecaseWithParameters<Type, Parameters> {
  const UsecaseWithParameters();
  ResultFuture<Type> call(Parameters parameters);
}

abstract class UsecaseWithoutParameters<Type> {
  const UsecaseWithoutParameters();
  ResultFuture<Type> call();
}
