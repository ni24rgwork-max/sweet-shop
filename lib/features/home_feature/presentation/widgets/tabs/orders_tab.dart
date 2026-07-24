import 'package:flutter/material.dart';

import '../../../../../core/widgets/general_app_bar.dart';
import '../orders_list_widget.dart';

/// Orders tab — active, completed and cancelled.
///
/// The tab bar's colours, indicator shape and label styles come from
/// `tabBarTheme`, so this only declares structure.
class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: 'My orders',
        showBackIcon: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          OrdersListWidget(orderType: OrderType.active),
          OrdersListWidget(orderType: OrderType.completed),
          OrdersListWidget(orderType: OrderType.canceled),
        ],
      ),
    );
  }
}
