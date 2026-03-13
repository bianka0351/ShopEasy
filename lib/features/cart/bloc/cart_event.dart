part of 'cart_bloc.dart';

abstract class CartEvent {}

class IncreaseQuantity extends CartEvent {}

class DecreaseQuantity extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final int productId;

  AddToCartEvent({required this.productId});
}
