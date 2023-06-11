import 'package:flutter/material.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';
import 'package:posapplication/shared/widgets/nodata_widget.dart';

class ListTransactionScreen extends StatefulWidget {
  List<OrdersModel>? dataList;
  String status;

  ListTransactionScreen({
    required this.status,
    this.dataList,
    super.key,
  });

  @override
  State<ListTransactionScreen> createState() => _ListTransactionScreenState();
}

class _ListTransactionScreenState extends State<ListTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    widget.dataList!
        .sort((a, b) => a.dateTimeOrder!.compareTo(b.dateTimeOrder!));

    print(">>> print datalist : ${widget.dataList}");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.status.toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: (widget.dataList!.isEmpty)
            ? NoDataWidget(
                description:
                    "Belum terdapat data, lakukan input untuk melakukan transaksi.")
            : ListView.separated(
                padding: const EdgeInsets.all(18),
                separatorBuilder: (context, index) => const Divider(
                  thickness: 0.5,
                  height: 25,
                  color: Colors.black,
                ),
                shrinkWrap: true,
                itemCount: widget.dataList?.length ?? 0,
                itemBuilder: (context, index) {
                  OrdersModel datas = widget.dataList![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailTransactionScreen(orderCustomer: datas),
                          ));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                datas.dataCustomer?.fullname.toString() ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                  "Pesanan : ${datas.dataItem?.length ?? 0} Item"),
                              Text(
                                "Waktu Pesan :${DateUtil.convertToOnlyTime(datas.dateTimeOrder!)}",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(datas.dataTable?.tableName.toString() ?? ""),
                              Text(datas.status.toUpperCase().toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
