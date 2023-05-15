import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/export_model.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';
import 'package:posapplication/shared/widgets/separator_dash_widget.dart';

import '../../data/model/profile_model.dart';
import '../../shared/routes/app_routes.dart';

class OrdersConfirmationScreen extends StatefulWidget {
  // List<OrdersModel> orderList = [];

  OrdersConfirmationScreen({
    super.key,
  });

  @override
  State<OrdersConfirmationScreen> createState() =>
      _OrdersConfirmationScreenState();
}

class _OrdersConfirmationScreenState extends State<OrdersConfirmationScreen> {
  final Map<String, int> counts = {};
  List<OrdersModel> orderList = [];

  countUniqueData() {
    for (var element in orderList) {
      List<ItemsModel>? itemList = element.dataItem;

      if (itemList != null) {
        for (var data in itemList) {
          if (counts.containsKey(data.itemName)) {
            counts[data.itemName] = counts[data.itemName]! + 1;
          } else {
            counts[data.itemName] = 1;
          }
        }
      }
    }
  }

  fillEmptyData() {
    // fill date order
    for (var element in orderList) {
      element.dateTimeOrder = DateTime.now();
    }
  }

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Transaksi"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomWidgets.showConfirmation(context, "Lanjut Proses Pemesanan ? ",
              () {
            fillEmptyData();
            context
                .read<OrdersBloc>()
                .add(ProcessOrdersEvent(requestOrder: orderList));

            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.ownerBottomNav, (route) => false);
          });
        },
        child: const Icon(Icons.check_outlined),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is LoadingConfirmationOrder) {
                return CustomWidgets.showLoadingWidget();
              }

              if (state is FailureConfirmationOrder) {
                return Text(state.messageError);
              }

              if (state is SuccessConfirmationOrder) {
                ProfileModel profileData = state.profileModel;
                orderList = state.requestOrder;
                countUniqueData();

                // print(orderList);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(profileData.bussinessName.toString()),
                    Text(
                      profileData.bussinessAddress.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "No. Telp : ${profileData.bussinessPhone}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    const Text("Nota Pemesanan"),
                    const SeparatorDashWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Nama Pelanggan :"),
                        Text(orderList.first.dataCustomer?.fullname ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("No. Meja :"),
                        Text(orderList.first.dataTable?.tableNo ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Dibuat oleh :"),
                        Text(orderList.first.staffHandleBy ?? ""),
                        // Text(state.requestOrder.first.staffHandleBy ?? ""),
                      ],
                    ),
                    const SeparatorDashWidget(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: counts.length,
                      itemBuilder: (context, index) {
                        String key = counts.keys.elementAt(index);
                        int value = counts[key]!;
                        return ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(key),
                          trailing: Text(value.toString()),
                        );
                      },
                    ),
                    const SeparatorDashWidget(),
                    const Text(
                      "Terima Kasih, Silahkan Menunggu",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
