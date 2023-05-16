import 'package:flutter/material.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';

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
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.status.toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: ListView.separated(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (context, index) => const Divider(),
        shrinkWrap: true,
        itemCount: widget.dataList?.length ?? 0,
        itemBuilder: (context, index) {
          OrdersModel datas = widget.dataList![index];
          return Row(
            children: [
              Container(
                color: Colors.red,
                width: (_width / 2) - 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(datas.dataCustomer?.fullname.toString() ?? ""),
                    Text(
                        "Waktu Pesan :${DateUtil.convertToOnlyTime(datas.dateTimeOrder!)}")
                  ],
                ),
              ),
              Container(
                color: Colors.amber,
                width: (_width / 2) - 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(datas.dataTable?.tableName.toString() ?? ""),
                    Text(datas.status.toString()),
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
