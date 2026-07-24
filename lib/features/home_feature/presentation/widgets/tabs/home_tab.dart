import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/routes.dart';
import '../../../../../core/theme/dimens.dart';
import '../../../../../core/widgets/app_search_bar.dart';
import '../../../../../core/widgets/app_title_widget.dart';
import '../../../../cart_feature/data/data_source/local/fake_products.dart';
import '../banner_slider_widget.dart';
import '../categories_list.dart';
import '../home_app_bar.dart';
import '../products_list.dart';

/// Home.
///
/// A [CustomScrollView] so the greeting can collapse as you scroll, which a
/// plain `SingleChildScrollView` could not do. Bottom padding clears the floating
/// navigation bar, since the shell sets `extendBody`.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const HomeHeader(),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.gutter,
            Dimens.padding,
            Dimens.gutter,
            Dimens.veryLargePadding,
          ),
          sliver: SliverToBoxAdapter(
            child: AppSearchBar(
              suggestions: <String>[
                for (final product in FakeProducts.products) product.name,
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: AppTitleWidget(
            title: 'Special offers',
            onPressed: () => context.push(Routes.specialOffers),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: Dimens.mediumPadding),
            child: BannerSliderWidget(),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: Dimens.veryLargePadding),
            child: AppTitleWidget(
              title: 'Categories',
              onPressed: () => context.push(Routes.categories),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: Dimens.mediumPadding),
            child: CategoriesList(),
          ),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: Dimens.veryLargePadding),
            child: ProductsList(),
          ),
        ),

        // Clears the floating navigation bar.
        const SliverToBoxAdapter(child: SizedBox(height: 108)),
      ],
    );
  }
}
