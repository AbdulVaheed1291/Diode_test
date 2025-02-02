import 'package:flutter/cupertino.dart';

import '../../../model/apimodels/Api_Model.dart';

@immutable
sealed class AllState {}

final class AllInitial extends AllState {}

final class AllLoading extends AllState {}

final class AllSuccess extends AllState {
  final List<Product> products;

  AllSuccess(this.products);
}

final class AllFailure extends AllState {
  final String errorMessage;

  AllFailure(this.errorMessage);
}
