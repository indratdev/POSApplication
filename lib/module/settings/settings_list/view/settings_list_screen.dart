import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/module/Users/bloc/users_bloc.dart';
import 'package:posapplication/module/Users/user_dashboard/view/user_dashboard_screen.dart';
import 'package:posapplication/module/customers/bloc/customers_bloc.dart';
import 'package:posapplication/module/customers/view/customers_dashboard/customers_dashboard_screen.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
import 'package:posapplication/module/settings/category/view/category_dashboard_screen.dart';
import 'package:posapplication/module/settings/settings_list/view/settings_widget.dart';
import 'package:posapplication/module/settings/tables/bloc/tables_bloc.dart';

import '../../../owner/owner_profile/view/owner_profile_info_screen.dart';
import '../../bloc/settings_bloc.dart';
import '../../tables/views/tables_dashboard_screen.dart';

class SettingsListScreen extends StatefulWidget {
  const SettingsListScreen({super.key});

  @override
  State<SettingsListScreen> createState() => _SettingsListScreenState();
}

class _SettingsListScreenState extends State<SettingsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        centerTitle: true,
      ),
      body: GridView.count(
        primary: false,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          SettingsWidget(
            menu: "Profil",
            iconName: Icons.person,
            screenToOpen: OwnerProfileInfoScreen(),
            bloc: BlocProvider.of<OwnerBloc>(context),
            eventToCall: OpenBoxProfileEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Pengguna",
            iconName: Icons.manage_accounts,
            screenToOpen: UserDashboardScreen(),
            bloc: BlocProvider.of<UsersBloc>(context),
            eventToCall: GetAllUsersEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Pelanggan",
            iconName: Icons.person,
            screenToOpen: CustomersDashboardScreen(),
            bloc: BlocProvider.of<CustomersBloc>(context),
            eventToCall: GetAllCustomersEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Meja",
            iconName: Icons.table_bar,
            screenToOpen: TablesDashboardScreen(),
            bloc: BlocProvider.of<TablesBloc>(context),
            eventToCall: GetAllTablesEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Kategori",
            iconName: Icons.category,
            screenToOpen: CategoryDashboardScreen(),
            bloc: BlocProvider.of<SettingsBloc>(context),
            eventToCall: GetAllCategoryEvent(),
          ),
        ],
      ),
    );
  }
}
