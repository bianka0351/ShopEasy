import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/features/home/data/models/product_model.dart';
import 'package:shop_easy/features/home/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  List<ProductModel> _allProducts = [];
  ProductBloc(this.repository) : super(ProductInitial()) {
    /// LOAD PRODUCTS
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());

      final products = await repository.getProducts();
      products.fold(
        (failure) {
          emit(ProductError('Failed to load products'));
        },
        (success) {
          _allProducts = success;
          emit(ProductLoaded(success));
        },
      );
    });

    /// SEARCH PRODUCTS
    on<SearchProductsEvent>((event, emit) {
      final query = event.query.toLowerCase().trim();

      if (query.isEmpty) {
        emit(ProductLoaded(_allProducts));
        return;
      }

      final filteredProducts = _allProducts.where((product) {
        final titleMatch = product.title.toLowerCase().contains(query);

        final brandMatch =
            product.brand?.toLowerCase().contains(query) ?? false;

        return titleMatch || brandMatch;
      }).toList();

      emit(ProductLoaded(filteredProducts));
    });
  }
}
