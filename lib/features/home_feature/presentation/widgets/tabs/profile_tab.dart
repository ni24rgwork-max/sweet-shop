import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/theme/dimens.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/widgets/app_list_tile.dart';
import '../../../../../core/widgets/app_svg_viewer.dart';
import '../../../../../core/widgets/general_app_bar.dart';
import '../../../../../core/widgets/user_profile_image_widget.dart';
import '../../bloc/theme_cubit.dart';

/// Profile and settings.
///
/// Uses Material [Switch]es rather than [CupertinoSwitch] so the controls match
/// the rest of the design system on both platforms, and groups rows into tonal
/// cards under section headings.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const GeneralAppBar(title: 'Profile', showBackIcon: false),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.padding,
          Dimens.gutter,
          // Clears the floating navigation bar.
          108,
        ),
        children: <Widget>[
          _ProfileCard(),

          const SizedBox(height: Dimens.veryLargePadding),
          _SectionLabel('General'),
          _Group(
            children: <Widget>[
              AppListTile(
                onTap: () {},
                title: 'Payment methods',
                leadingIconPath: Assets.icons.cardPos,
                padding: EdgeInsets.zero,
              ),
              AppListTile(
                onTap: () {},
                title: 'Addresses',
                leadingIconPath: Assets.icons.location,
                padding: EdgeInsets.zero,
              ),
              AppListTile(
                onTap: () {},
                title: 'Language',
                leadingIconPath: Assets.icons.languageSquare,
                padding: EdgeInsets.zero,
              ),
              AppListTile(
                onTap: () {},
                title: 'Notifications',
                leadingIconPath: Assets.icons.notification,
                padding: EdgeInsets.zero,
                trailing: Switch(value: true, onChanged: (_) {}),
              ),
              AppListTile(
                onTap: () => context.read<ThemeCubit>().toggleTheme(
                  isCurrentlyDark: isDark,
                ),
                title: 'Dark theme',
                leadingIconPath: Assets.icons.moon,
                padding: EdgeInsets.zero,
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) => context.read<ThemeCubit>().toggleTheme(
                    isCurrentlyDark: isDark,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: Dimens.veryLargePadding),
          _SectionLabel('Support'),
          _Group(
            children: <Widget>[
              AppListTile(
                onTap: () {},
                title: 'Feedback',
                leadingIconPath: Assets.icons.noteText,
                padding: EdgeInsets.zero,
              ),
              AppListTile(
                onTap: () {},
                title: 'Help and support',
                leadingIconPath: Assets.icons.infoCircle,
                padding: EdgeInsets.zero,
              ),
            ],
          ),

          const SizedBox(height: Dimens.veryLargePadding),
          _Group(
            children: <Widget>[
              AppListTile(
                onTap: () {},
                title: 'Log out',
                leadingIconPath: Assets.icons.logout,
                padding: EdgeInsets.zero,
                destructive: true,
                trailing: const SizedBox.shrink(),
              ),
            ],
          ),

          const SizedBox(height: Dimens.largePadding),
          Center(
            child: Text(
              'Sweet Shop · v1.0.0',
              style: context.text.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(Dimens.mediumPadding),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppShapes.radiusXl,
      ),
      child: Row(
        children: <Widget>[
          const UserProfileImageWidget(width: 58, height: 58),
          const SizedBox(width: Dimens.mediumPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Vanessa Lennox', style: context.text.titleLarge),
                const SizedBox(height: 2),
                Text(
                  'vanessalennox@gmail.com',
                  style: context.text.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: colors.surfaceContainerHigh,
              shape: AppShapes.pill,
            ),
            icon: AppSvgViewer(
              Assets.icons.edit,
              width: 18,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.smallPadding,
        bottom: Dimens.mediumPadding,
      ),
      child: Text(text, style: context.text.headlineSmall),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimens.smallPadding),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: AppShapes.radiusXl,
      ),
      child: Column(children: children),
    );
  }
}
