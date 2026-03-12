part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductLoaded extends ProductState {
  final List<ProductModel> allProducts; // كل المنتجات
  final List<ProductModel> displayedProducts; // المنتجات بعد الفلترة والبحث
  final List<String> categories; // قائمة الفئات مع All
  final String? selectedCategory; // الفئة المختارة
  final String searchQuery; // نص البحث

  ProductLoaded({
    required this.allProducts,
    required this.displayedProducts,
    required this.categories,
    this.selectedCategory,
    this.searchQuery = '',
  });

  // لتحديث الحالة بسهولة
  ProductLoaded copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? displayedProducts,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return ProductLoaded(
      allProducts: allProducts ?? this.allProducts,
      displayedProducts: displayedProducts ?? this.displayedProducts,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
