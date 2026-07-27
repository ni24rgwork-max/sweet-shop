import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/general_app_bar.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Delivery address picker.
///
/// Like the payment screen, selection is owned by a single [RadioGroup] — the
/// other half of the deprecated-`Radio` cleanup, and the reason tapping an address
/// now selects it.
class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  static const List<_Address> _addresses = <_Address>[
    _Address('Home', 'Montgomery Street, Country Street East Pkwy'),
    _Address('Office', '1180 Sixth Avenue, Floor 12'),
    _Address("Parents' house", '54 Rosewood Lane, Brookfield'),
  ];

  String _selected = _addresses.first.label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Scaffold(
      appBar: const GeneralAppBar(title: 'Change address'),
      body: RadioGroup<String>(
        groupValue: _selected,
        onChanged: (String? value) {
          if (value != null) setState(() => _selected = value);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Dimens.gutter,
            Dimens.padding,
            Dimens.gutter,
            Dimens.gutter,
          ),
          children: <Widget>[
            for (final _Address address in _addresses) ...<Widget>[
              _AddressTile(
                address: address,
                selected: _selected == address.label,
                onTap: () => setState(() => _selected = address.label),
              ),
              const SizedBox(height: Dimens.mediumPadding),
            ],

            const SizedBox(height: Dimens.padding),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: const <double>[6, 4],
                strokeWidth: 1.5,
                radius: const Radius.circular(AppShapes.md),
                color: colors.outline,
                padding: EdgeInsets.zero,
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: AppShapes.radiusMd,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.mediumPadding),
                    child: Center(
                      child: Text(
                        '+  Add a new address',
                        style: context.text.labelLarge?.copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.padding,
          Dimens.gutter,
          Dimens.mediumPadding,
        ),
        child: FilledButton(
          onPressed: () => context.pop(),
          child: const Text('Apply'),
        ),
      ),
    );
  }
}

class _Address {
  const _Address(this.label, this.detail);

  final String label;
  final String detail;
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    required this.address,
    required this.selected,
    required this.onTap,
  });

  final _Address address;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Material(
      color: selected ? colors.secondaryContainer : colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppShapes.radiusMd,
        side: BorderSide(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.mediumPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Symbols.location_on,
                  size: 20,
                  color: selected ? colors.primary : colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: Dimens.mediumPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(address.label, style: context.text.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      address.detail,
                      style: context.text.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Radio<String>(value: address.label),
            ],
          ),
        ),
      ),
    );
  }
}
