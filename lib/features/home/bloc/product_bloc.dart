import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/features/home/data/models/product_model.dart';
import 'package:shop_easy/features/home/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  List<ProductModel> _allProducts = [];

  ProductBloc(this.repository) : super(ProductInitial()) {
    /// تحميل المنتجات
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await repository.getProducts();
      result.fold((failure) => emit(ProductError('Failed to load products')), (
        success,
      ) {
        _allProducts = success;

        // استخراج الفئات مع إضافة "All"
        final categories =
            ['All'] + _allProducts.map((p) => p.category.name).toSet().toList();
        emit(
          ProductLoaded(
            allProducts: _allProducts,
            displayedProducts: _allProducts,
            categories: categories,
            selectedCategory: 'All',
          ),
        );
      });
    });

    /// البحث
    on<SearchProductsEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(
          currentState.copyWith(
            searchQuery: event.query,
            displayedProducts: _filterProducts(
              allProducts: currentState.allProducts,
              category: currentState.selectedCategory!,
              query: event.query,
            ),
          ),
        );
      }
    });

    /// فلترة حسب الفئة
    on<FilterByCategoryEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final category = event.category ?? 'All'; // null تعني All
        final filteredProducts = _filterProducts(
          allProducts: currentState.allProducts,
          category: category,
          query: currentState.searchQuery,
        );
        emit(
          currentState.copyWith(
            selectedCategory: category,
            displayedProducts: filteredProducts,
          ),
        );
      }
    });
  }

  /// دالة فلترة المنتجات
  List<ProductModel> _filterProducts({
    required List<ProductModel> allProducts,
    required String category,
    String? query,
  }) {
    return allProducts.where((p) {
      final matchesCategory = category == 'All' || p.category.name == category;
      final matchesQuery = query == null || query.isEmpty
          ? true
          : (p.title.toLowerCase().contains(query.toLowerCase()) ||
                p.category.name.toLowerCase().contains(query.toLowerCase()));
      return matchesCategory && matchesQuery;
    }).toList();
  }
}
