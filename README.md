# 🍰 Sweet Shop

A Flutter storefront app for a bakery — browsing, product details, cart, checkout,
and store locator — rebuilt on **Material 3 Expressive** with a custom dusty-berry
palette and full light/dark support.

## Screenshots

_Coming soon — the UI was rebuilt and the previous screenshots no longer match._

<!--
Drop captures into assets/demos/ and reference them with relative paths:
![Home](assets/demos/home.png)
-->

## The redesign

The app was reworked from the ground up onto Material 3 Expressive:

- **Token-driven theme system** — `app_color_scheme`, `app_typography`, `app_shapes`,
  `app_motion` and `app_semantics` replace the previous flat colour and text constants,
  so the entire app re-themes from one seed colour.
- **Dusty-berry palette** seeded from `#A8536B`, with hand-tuned surface ramps for both
  light (`#FFF8F5`) and dark (`#1A1113`) rather than relying on generated defaults alone.
- **Navigation migrated to `go_router`** — declarative routes and a shell-based tab
  layout, replacing imperative navigator calls.
- **Every widget rebuilt** against the new tokens: buttons, chips, list tiles, search
  bar, app bars, dividers, rating and map widgets.
- **iOS project modernised** to a minimum of iOS 13 with the UIScene lifecycle.

## Features

- Product browsing with categories, sorting and filtering
- Product details with expandable descriptions and ratings
- Cart, address selection, payment methods and checkout flow
- Special offers and a promotional banner carousel
- Store locator built on `flutter_map`
- Light and dark themes

## Tech stack

- **Flutter** with a feature-first structure (`core/` + `features/`, each split into
  `data/` and `presentation/`)
- **State management** — `bloc` / `flutter_bloc` (Cubit)
- **Routing** — `go_router`
- **UI** — `material_symbols_icons`, `google_fonts`, `animations`, `flutter_svg`,
  `readmore`, `dotted_border`
- **Assets** — `flutter_gen` for type-safe asset references
- **Maps** — `flutter_map`

## Getting started

```bash
git clone https://github.com/ni24rgwork-max/sweet-shop.git
cd sweet-shop
flutter pub get
flutter run
```

Requires a recent Flutter SDK with Material 3 support.

## Credits

The original Sweet Shop UI base is by
[ales-dev-studio](https://github.com/ales-dev-studio/Flutter-Sweet-Shop-App-UI),
from the [Sweet Craze](https://www.figma.com/design/kgbuMUCvaYoMXLRjDxkZ6s/Sweet-Craze?node-id=1-2&t=ynInnRvFPLgl3VuP-1)
Figma design. The Material 3 Expressive redesign, theming system, routing migration
and platform updates in this repository are my own work.
