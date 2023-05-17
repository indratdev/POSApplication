import 'package:flutter/material.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

class DetailTransactionScreen extends StatefulWidget {
  OrdersModel? orderCustomer;

  DetailTransactionScreen({
    this.orderCustomer,
    super.key,
  });

  @override
  State<DetailTransactionScreen> createState() =>
      _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    print(">>> status aaa: ${widget.orderCustomer!.status}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // no pesanan
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "No. Pesanan",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    TextUtil.substringAndEclipsText(
                        widget.orderCustomer?.orderID ?? ""),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Tanggal Pesanan",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(DateUtil.convertToDayAndDateTime(
                      widget.orderCustomer!.dateTimeOrder!)),
                ],
              ),
            ),
            Divider(color: Colors.green.shade200, thickness: 1, height: 1),

            // customer data
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderCustomer!.dataCustomer?.fullname ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.orderCustomer!.dataCustomer?.phoneNumber ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chat_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.green.shade200, thickness: 1, height: 1),

            // customer data
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${widget.orderCustomer!.dataItem?.length ?? 0} Item Pesanan"),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.find_in_page_outlined))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.event_note_rounded),
                      SizedBox(width: 10),
                      Text("Catatan"),
                    ],
                  ),
                ],
              ),
            ),

            // container proses
            Container(
              // color: Colors.amber,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: [
                  Text(
                    '"Pesanan ini masih dalam status ${widget.orderCustomer?.status ?? ''}" \n Anda dapat melihat catatan untuk kemudahan',
                    textAlign: TextAlign.center,
                  ),
                  (widget.orderCustomer!.status == StatusOrder.cancel.name ||
                          widget.orderCustomer!.status ==
                              StatusOrder.waiting.name)
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  (widget.orderCustomer!.status ==
                                              StatusOrder.open.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.progress.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.done.name)
                                      ? Icons.circle
                                      : Icons.circle_outlined,
                                  color: (widget.orderCustomer!.status ==
                                              StatusOrder.open.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.progress.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.done.name)
                                      ? Colors.blue
                                      : null,
                                ),
                                Text(StatusOrder.open.name
                                    .toUpperCase()
                                    .toString())
                              ],
                            ),
                            Icon(Icons.maximize),
                            Column(
                              children: [
                                Icon(
                                  (widget.orderCustomer!.status !=
                                          StatusOrder.open.name)
                                      ? Icons.circle
                                      : Icons.circle_outlined,
                                  color: (widget.orderCustomer!.status !=
                                          StatusOrder.open.name)
                                      ? Colors.blue
                                      : null,
                                ),
                                Text(StatusOrder.progress.name
                                    .toUpperCase()
                                    .toString())
                              ],
                            ),
                            Icon(Icons.maximize),
                            Column(
                              children: [
                                Icon(
                                  (widget.orderCustomer!.status ==
                                              StatusOrder.open.name ||
                                          widget.orderCustomer!.status !=
                                              StatusOrder.progress.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.done.name)
                                      ? Icons.circle
                                      : Icons.circle_outlined,
                                  color: (widget.orderCustomer!.status ==
                                              StatusOrder.open.name ||
                                          widget.orderCustomer!.status !=
                                              StatusOrder.progress.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.done.name)
                                      ? Colors.blue
                                      : null,
                                ),
                                Text(StatusOrder.done.name
                                    .toUpperCase()
                                    .toString())
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
