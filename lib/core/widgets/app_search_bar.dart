import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Search entry point.
///
/// Uses [SearchAnchor.bar] rather than a bare `TextFormField`, so tapping it
/// expands into a full search view with suggestions and the platform's own
/// transition — behaviour the previous hand-rolled field had no way to provide.
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key, this.suggestions = const <String>[]});

  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SearchAnchor.bar(
      barHintText: 'Search cakes, pastries, cheesecakes',
      barLeading: Padding(
        padding: const EdgeInsets.only(right: Dimens.smallPadding),
        child: Icon(
          Symbols.search,
          size: 20,
          color: colors.onSurfaceVariant,
        ),
      ),
      viewHintText: 'What are you craving?',
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final String query = controller.text.trim().toLowerCase();
        final Iterable<String> matches = query.isEmpty
            ? suggestions
            : suggestions.where(
                (String s) => s.toLowerCase().contains(query),
              );

        if (matches.isEmpty) {
          return <Widget>[
            Padding(
              padding: const EdgeInsets.all(Dimens.largePadding),
              child: Text(
                'Nothing matches "${controller.text}"',
                style: context.text.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ];
        }

        return matches.map((String item) {
          return ListTile(
            leading: Icon(Symbols.search, size: 18),
            title: Text(item, style: context.text.bodyLarge),
            onTap: () => controller.closeView(item),
          );
        }).toList();
      },
    );
  }
}
