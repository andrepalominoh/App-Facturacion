import 'package:flutter/material.dart';
import 'package:lya_encuestas/collapsible_navigation_drawer/model/drawer_item.dart';

final itemsFirst = [
  const DrawerItem(
      code: "profile", title: "Perfil", icon: Icons.account_circle_outlined),
  /*const DrawerItem(
      code: "surveys", title: "Encuestas", icon: Icons.insert_chart),*/
  const DrawerItem(
      code: "sell_points",
      title: 'Puntos de venta',
      icon: Icons.local_convenience_store_rounded),
  const DrawerItem(
      code: "add_sell_points",
      title: 'Altas - Puntos de venta',
      icon: Icons.add_business),
  const DrawerItem(
      code: "add_skus", title: 'Altas - SKUs', icon: Icons.add_shopping_cart),
];

final itemsSecond = [
  const DrawerItem(code: "logout", title: 'Logout', icon: Icons.logout),
];
