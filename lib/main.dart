import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_easy/core/constants/app_routes.dart';
import 'package:shop_easy/features/cart/data/models/cart_item_model.dart';
import 'package:shop_easy/features/home/bloc/product_bloc.dart';
import 'package:shop_easy/features/home/data/repositories/product_repository.dart';
import 'package:shop_easy/features/navigation/cubit/bottom_nav_cubit.dart';
import 'package:shop_easy/features/splash/presentation/splash_screen.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) =>
              ProductBloc(ProductRepository())..add(LoadProductsEvent()),
        ),
        BlocProvider(create: (_) => BottomNavCubit()),
      ],
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: AppRoutes.routes,
      ),
    );
  }
}
