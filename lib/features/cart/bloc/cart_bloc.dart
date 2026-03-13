import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/features/cart/data/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded()) {
    on<IncreaseQuantity>((event, emit) {
      if (state is CartLoaded) {
        final current = state as CartLoaded;

        emit(current.copyWith(quantity: current.quantity + 1));
      }
    });

    on<DecreaseQuantity>((event, emit) {
      if (state is CartLoaded) {
        final current = state as CartLoaded;

        if (current.quantity > 1) {
          emit(current.copyWith(quantity: current.quantity - 1));
        }
      }
    });

    on<AddToCartEvent>((event, emit) async {
      if (state is CartLoaded) {
        final current = state as CartLoaded;

        emit(current.copyWith(isLoading: true, error: null));

        final result = await CartRepository().addToCart(
          productId: event.productId,
          quantity: current.quantity,
        );

        result.fold(
          (failure) {
            emit(current.copyWith(isLoading: false, error: failure.message));
          },

          (data) {
            emit(current.copyWith(isLoading: false, addToCartSuccess: true));
          },
        );
      }
    });
  }
}
