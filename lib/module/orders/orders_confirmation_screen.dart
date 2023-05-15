import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/export_model.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/data/service/hive_service/hive_service.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/utils/general_function.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';
import 'package:posapplication/shared/widgets/separator_dash_widget.dart';

class OrdersConfirmationScreen extends StatefulWidget {
  List<OrdersModel> orderList;

  OrdersConfirmationScreen({
    super.key,
    required this.orderList,
  });

  @override
  State<OrdersConfirmationScreen> createState() =>
      _OrdersConfirmationScreenState();
}

class _OrdersConfirmationScreenState extends State<OrdersConfirmationScreen> {
  final Map<String, int> counts = {};

  countUniqueData() {
    for (var element in widget.orderList) {
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

      // old
      // String data = element.dataItem!.itemName;
      // if (counts.containsKey(data)) {
      //   counts[data] = counts[data]! + 1;
      // } else {
      //   counts[data] = 1;
      // }
    }
  }

  fillEmptyData() {
    // fill date order
    for (var element in widget.orderList) {
      element.dateTimeOrder = DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    countUniqueData();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

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
                .add(ProcessOrdersEvent(requestOrder: widget.orderList));
            GeneralFunction.navigationBackTwoStep(context);
          });
        },
        child: Icon(Icons.check_outlined),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Testing Barber"),
              Text(
                "Jl. Ampera Raya No. 133, RT.05/RW.10, Ragunan, Kec. Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta",
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Telp. (021) 22859672.",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 15),
              Text("Nota Pemesanan"),
              SeparatorDashWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nama Customer :"),
                  Text(widget.orderList.first.dataCustomer?.fullname ?? ""),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No. Meja :"),
                  Text(widget.orderList.first.dataTable?.tableNo ?? ""),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dibuat oleh :"),
                  Text(widget.orderList.first.staffHandleBy ?? ""),
                ],
              ),
              SeparatorDashWidget(),
              ListView.builder(
                shrinkWrap: true,
                // itemCount: widget.orderList.length,
                itemCount: counts.length,
                itemBuilder: (context, index) {
                  // OrdersModel items = widget.orderList[index];
                  String key = counts.keys.elementAt(index);
                  int value = counts[key]!;
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    // title: Text(items.dataItem?.itemName ?? ""),
                    title: Text(key),
                    trailing: Text(value.toString()),
                  );
                },
              ),
              SeparatorDashWidget(),
              Text(
                "Terima Kasih, Silahkan Menunggu",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
