import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../data/data_source/local/sample_data.dart';

/// All current offers, one per card.
class SpecialOffers extends StatelessWidget {
  const SpecialOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'Special offers'),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.padding,
          Dimens.gutter,
          Dimens.gutter,
        ),
        itemCount: banners.length,
        separatorBuilder: (_, _) => const SizedBox(height: Dimens.largePadding),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 2.2,
                    child: Image.asset(banners[index], fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.mediumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Offer ${index + 1}',
                            style: context.text.titleMedium,
                          ),
                        ),
                        Text(
                          'Ends in ${index + 2} days',
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
