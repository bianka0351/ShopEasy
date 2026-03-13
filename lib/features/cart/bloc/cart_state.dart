part of 'cart_bloc.dart';

abstract class CartState {}

class CartLoaded extends CartState {
  final int quantity;
  final bool isLoading;
  final String? error;
  final bool addToCartSuccess;
  CartLoaded({
    this.quantity = 1,
    this.isLoading = false,
    this.error,
    this.addToCartSuccess = false,
  });

  CartLoaded copyWith({
    int? quantity,
    bool? isLoading,
    String? error,
    bool? addToCartSuccess,
  }) {
    return CartLoaded(
      quantity: quantity ?? this.quantity,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      addToCartSuccess: addToCartSuccess ?? false,
    );
  }
}
