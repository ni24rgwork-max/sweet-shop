import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart_feature/presentation/screens/cart_screen.dart';
import '../../features/cart_feature/presentation/screens/change_address_screen.dart';
import '../../features/cart_feature/presentation/screens/payment_methods_screen.dart';
import '../../features/cart_feature/presentation/screens/proceed_to_checkout_screen.dart';
import '../../features/home_feature/presentation/screens/categories_screen.dart';
import '../../features/home_feature/presentation/screens/product_details_screen.dart';
import '../../features/home_feature/presentation/screens/products_screen.dart';
import '../../features/home_feature/presentation/screens/special_offers.dart';
import '../../features/home_feature/data/product_details_args.dart';
import '../../features/home_feature/presentation/screens/splash_screen.dart';
import '../../features/home_feature/presentation/widgets/app_shell.dart';
import '../../features/home_feature/presentation/widgets/tabs/home_tab.dart';
import '../../features/home_feature/presentation/widgets/tabs/orders_tab.dart';
import '../../features/home_feature/presentation/widgets/tabs/profile_tab.dart';
import '../../features/map_feature/screens/map_screen.dart';
import '../theme/app_motion.dart';
import 'routes.dart';

/// Declarative routing for the app.
///
/// The five bottom-nav destinations live in a [StatefulShellRoute.indexedStack]
/// so each keeps its own navigation stack and scroll position — an improvement
/// on the previous `tabs[selectedIndex]` swap, which rebuilt a tab from scratch
/// every time you came back to it.
///
/// Everything reachable from a tab is a top-level route rather than a nested
/// one, so pushed screens cover the navigation bar.
abstract final class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.splash,
        builder: (_, _) => const SplashScreen(),
      ),

      // The base constructor rather than the `indexedStack` factory, because
      // that factory hardcodes its container builder and this one cross-fades
      // between branches instead of cutting.
      StatefulShellRoute(
        builder: (_, _, StatefulNavigationShell shell) =>
            AppShell(shell: shell),
        navigatorContainerBuilder:
            (
              BuildContext context,
              StatefulNavigationShell shell,
              List<Widget> children,
            ) => BranchContainer(
              currentIndex: shell.currentIndex,
              children: children,
            ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: Routes.home, builder: (_, _) => const HomeTab()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: Routes.cart, builder: (_, _) => const CartScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.orders,
                builder: (_, _) => const OrdersTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: Routes.map, builder: (_, _) => const MapScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.profile,
                builder: (_, _) => const ProfileTab(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: Routes.products,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          const ProductsScreen(),
        ),
      ),
      GoRoute(
        path: Routes.productDetails,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          // The card passes the product plus its hero tag; falls back to sample
          // data when the route is opened without either.
          ProductDetailsScreen(args: state.extra as ProductDetailsArgs?),
        ),
      ),
      GoRoute(
        path: Routes.categories,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          const CategoriesScreen(),
        ),
      ),
      GoRoute(
        path: Routes.specialOffers,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          const SpecialOffers(),
        ),
      ),
      GoRoute(
        path: Routes.checkout,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          const ProceedToCheckoutScreen(),
        ),
      ),
      GoRoute(
        path: Routes.changeAddress,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          const ChangeAddressScreen(),
        ),
      ),
      GoRoute(
        path: Routes.paymentMethods,
        pageBuilder: (_, GoRouterState state) => _sharedAxis(
          state,
          const PaymentMethodsScreen(),
        ),
      ),
    ],
  );

  /// Shared-axis transition — the Material motion pattern for moving between
  /// peer screens in a flow. Uses the official `animations` implementation
  /// rather than a hand-rolled slide-and-fade.
  static CustomTransitionPage<void> _sharedAxis(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: AppMotion.normal,
      reverseTransitionDuration: AppMotion.fast,
      child: child,
      transitionsBuilder:
          (
            _,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
    );
  }
}
