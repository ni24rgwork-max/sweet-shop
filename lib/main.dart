import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'features/cart_feature/data/data_source/local/fake_products.dart';
import 'features/cart_feature/presentation/bloc/cart_cubit.dart';
import 'features/home_feature/presentation/bloc/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit()
            ..loadCart()
            ..addItem(FakeProducts.products[0])
            ..addItem(FakeProducts.products[1])
            ..addItem(FakeProducts.products[4])
            ..addItem(FakeProducts.products[6]),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (BuildContext context, ThemeMode themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Sweet Shop',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
