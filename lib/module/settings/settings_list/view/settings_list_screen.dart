import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:posapplication/module/settings/settings_list/view/settings_widget.dart';

import '../../../../module/export.dart';
import '../../../blocs/export_bloc.dart';

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
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          SettingsWidget(
            menu: "Profil",
            iconName: FontAwesomeIcons.userLarge,
            screenToOpen: const OwnerProfileInfoScreen(),
            bloc: BlocProvider.of<OwnerBloc>(context),
            eventToCall: OpenBoxProfileEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Pengguna",
            iconName: FontAwesomeIcons.peopleRoof,
            screenToOpen: const UserDashboardScreen(),
            bloc: BlocProvider.of<UsersBloc>(context),
            // eventToCall: GetAllUsersEvent(),
            eventToCall: GetAllUsersFromBoxEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Pelanggan",
            iconName: FontAwesomeIcons.peopleGroup,
            screenToOpen: const CustomersDashboardScreen(),
            bloc: BlocProvider.of<CustomersBloc>(context),
            eventToCall: GetAllCustomersEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Meja",
            iconName: FontAwesomeIcons.table,
            screenToOpen: const TablesDashboardScreen(),
            bloc: BlocProvider.of<TablesBloc>(context),
            eventToCall: GetAllTablesEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Kategori",
            iconName: FontAwesomeIcons.fileContract,
            screenToOpen: const CategoryDashboardScreen(),
            bloc: BlocProvider.of<SettingsBloc>(context),
            eventToCall: GetAllCategoryEvent(),
          ),
          SettingsWidget(
            menu: "Manajemen Item / Barang",
            iconName: FontAwesomeIcons.fileInvoice,
            screenToOpen: const ItemsDashboardScreen(),
            bloc: BlocProvider.of<SettingsBloc>(context),
            eventToCall: GetAllItemsEvent(),
          ),
        ],
      ),
    );
  }
}
