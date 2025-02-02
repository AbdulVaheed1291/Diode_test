// productorder_state.dart
part of 'productorder_cubit.dart';

@immutable
sealed class ProductorderState {}

class ProductorderInitial extends ProductorderState {}

class ProductorderLoading extends ProductorderState {}

class ProductorderLoaded extends ProductorderState {
  final List<OrderItem> orders;

  ProductorderLoaded(this.orders);
}

class ProductorderError extends ProductorderState {
  final String message;

  ProductorderError(this.message);
}