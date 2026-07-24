import 'package:flutter/material.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../widgets/payment_item_widget.dart';

/// Payment method picker.
///
/// A single [RadioGroup] owns the selection for every method on the screen, which
/// is both the non-deprecated API and the reason selection now actually moves
/// when you tap — previously every radio was hardcoded against `groupValue: true`.
class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String _method = 'cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'Payment methods'),
      body: RadioGroup<String>(
        groupValue: _method,
        onChanged: (String? value) {
          if (value != null) setState(() => _method = value);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Dimens.gutter,
            Dimens.padding,
            Dimens.gutter,
            Dimens.gutter,
          ),
          children: <Widget>[
            PaymentItemWidget(
              title: 'Cash',
              value: 'cash',
              iconPath: Assets.icons.money3,
              selected: _method == 'cash',
              onTap: () => setState(() => _method = 'cash'),
            ),
            const SizedBox(height: Dimens.mediumPadding),
            PaymentItemWidget(
              title: 'Wallet',
              value: 'wallet',
              iconPath: Assets.icons.wallet,
              selected: _method == 'wallet',
              onTap: () => setState(() => _method = 'wallet'),
            ),

            const SizedBox(height: Dimens.largePadding),
            Text('Add a credit card', style: context.text.titleMedium),
            const SizedBox(height: Dimens.mediumPadding),
            PaymentItemWidget(
              title: 'Add card',
              iconPath: Assets.icons.card,
              showRadio: false,
              onTap: () {},
            ),

            const SizedBox(height: Dimens.largePadding),
            Text('More payment options', style: context.text.titleMedium),
            const SizedBox(height: Dimens.mediumPadding),
            PaymentItemWidget(
              title: 'PayPal',
              value: 'paypal',
              logoPath: Assets.icons.paypalLogo,
              selected: _method == 'paypal',
              onTap: () => setState(() => _method = 'paypal'),
            ),
            const SizedBox(height: Dimens.mediumPadding),
            PaymentItemWidget(
              title: 'Apple Pay',
              value: 'apple',
              logoPath: Assets.icons.appleLogo,
              selected: _method == 'apple',
              onTap: () => setState(() => _method = 'apple'),
            ),
            const SizedBox(height: Dimens.mediumPadding),
            PaymentItemWidget(
              title: 'Google Pay',
              value: 'google',
              logoPath: Assets.icons.googleLogo,
              selected: _method == 'google',
              onTap: () => setState(() => _method = 'google'),
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
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order confirmed')),
            );
          },
          child: const Text('Confirm payment'),
        ),
      ),
    );
  }
}
