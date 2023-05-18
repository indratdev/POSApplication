import 'package:flutter/material.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

import '../../../shared/constants/constatns.dart';

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
  // 0 : open, 1 : waiting, 2 : progress, 3 : cancel, 4 : done
  // int status = 0;
  String statusImage = "";
  Map<String, dynamic> statusMap = {};

  @override
  void initState() {
    // TODO: implement initState
    // checkStatusOrder();
    checkImageStatus();
    super.initState();
  }

  checkImageStatus() {
    if (widget.orderCustomer!.status == StatusOrder.open.name) {
      // statusImage = workProcess;
      statusMap["image"] = workProcess;
      statusMap["description"] = "Transaksi Sudah Didaftarkan";
    }
    if (widget.orderCustomer!.status == StatusOrder.waiting.name) {
      // statusImage = "";
      statusMap["image"] = "";
      statusMap["description"] = "Menunggu";
    }
    if (widget.orderCustomer!.status == StatusOrder.progress.name) {
      // statusImage = check;
      statusMap["image"] = check;
      statusMap["description"] = "Transaksi Sedang Diproses";
    }
    if (widget.orderCustomer!.status == StatusOrder.cancel.name) {
      // statusImage = failure;
      statusMap["image"] = failure;
      statusMap["description"] = "Transaksi Dibatalkan / Gagal";
    }
    if (widget.orderCustomer!.status == StatusOrder.done.name) {
      // statusImage = excellence;
      statusMap["image"] = excellence;
      statusMap["description"] = "Transaksi Berhasil";
    }
  }
  // checkStatusOrder() {
  //   if (widget.orderCustomer!.status == StatusOrder.open.name) {
  //     status = 0;
  //   }
  //   if (widget.orderCustomer!.status == StatusOrder.waiting.name) {
  //     status = 1;
  //   }
  //   if (widget.orderCustomer!.status == StatusOrder.progress.name) {
  //     status = 2;
  //   }
  //   if (widget.orderCustomer!.status == StatusOrder.cancel.name) {
  //     status = 3;
  //   }
  //   if (widget.orderCustomer!.status == StatusOrder.done.name) {
  //     status = 4;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(">>> status aaa: ${widget.orderCustomer!.status}");
    print(">>> status bbb: ${statusImage}");

    double _width = MediaQuery.of(context).size.width;
    int _widthIcon = _width ~/ 5;

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
              padding: EdgeInsets.symmetric(vertical: 18),
              // color: Colors.amber,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: [
                  Text(
                    '"Pesanan ini masih dalam status ${widget.orderCustomer?.status ?? ''}" \n Anda dapat melihat catatan untuk kemudahan',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  (widget.orderCustomer!.status == StatusOrder.cancel.name ||
                          widget.orderCustomer!.status ==
                              StatusOrder.waiting.name)
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  // (status == 0 || status == 2 || status == 4)
                                  (widget.orderCustomer!.status ==
                                              StatusOrder.open.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.progress.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.done.name)
                                      ? Icons.circle
                                      : Icons.circle_outlined,
                                  color:
                                      // (status == 0 ||
                                      //         status == 2 ||
                                      //         status == 4)
                                      (widget.orderCustomer!.status ==
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
                                  // (status == 0)
                                  (widget.orderCustomer!.status ==
                                          StatusOrder.open.name)
                                      ? Icons.circle_outlined
                                      : Icons.circle,
                                  color:
                                      // (status == 0)
                                      (widget.orderCustomer!.status ==
                                              StatusOrder.open.name)
                                          ? null
                                          : Colors.blue,
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
                                  // (status == 0 || status == 2)
                                  (widget.orderCustomer!.status ==
                                              StatusOrder.open.name ||
                                          widget.orderCustomer!.status ==
                                              StatusOrder.progress.name)
                                      ? Icons.circle_outlined
                                      : Icons.circle,
                                  color:
                                      // (status == 0 || status == 2)
                                      (widget.orderCustomer!.status ==
                                                  StatusOrder.open.name ||
                                              widget.orderCustomer!.status ==
                                                  StatusOrder.progress.name)
                                          ? null
                                          : Colors.blue,
                                ),
                                Text(
                                  StatusOrder.done.name
                                      .toUpperCase()
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 55),
                  (widget.orderCustomer!.status == StatusOrder.done.name ||
                          widget.orderCustomer!.status ==
                              StatusOrder.cancel.name)
                      ? Column(
                          children: [
                            Image.asset(
                              statusMap["image"],
                              cacheWidth: _width ~/ 3,
                              color: (statusMap["image"] == excellence)
                                  ? Colors.green.shade500
                                  : Colors.red.shade900,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              statusMap["description"],
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                            // ElevatedButton(
                            //   onPressed: (widget.orderCustomer!.status ==
                            //           StatusOrder.progress.name)
                            //       ? null
                            //       : () {},
                            //   child: Text("PROSES PESANAN"),
                            // ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              foregroundDecoration: (widget
                                          .orderCustomer!.status ==
                                      StatusOrder.progress.name)
                                  ? const BoxDecoration(
                                      color: Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    )
                                  : BoxDecoration(
                                      color: Colors.green.shade500,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                              // width: MediaQuery.of(context).size.width / 3,
                              // height: MediaQuery.of(context).size.width / 3,
                              // color: Colors.amber,
                              child: Column(
                                children: [
                                  Image.asset(
                                    workProcess,
                                    cacheWidth: _widthIcon,
                                    color: Colors.green.shade500,
                                  ),
                                  ElevatedButton(
                                    onPressed: (widget.orderCustomer!.status ==
                                            StatusOrder.progress.name)
                                        ? null
                                        : () {},
                                    child: Text("PROSES PESANAN"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              foregroundDecoration: (widget
                                          .orderCustomer!.status ==
                                      StatusOrder.open.name)
                                  ? const BoxDecoration(
                                      color: Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    )
                                  : BoxDecoration(
                                      color: Colors.green.shade500,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                              // width: MediaQuery.of(context).size.width / 3,
                              // height: MediaQuery.of(context).size.width / 3,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Image.asset(
                                    check,
                                    cacheWidth: _widthIcon,
                                    color: Colors.green.shade500,
                                  ),
                                  ElevatedButton(
                                    onPressed: (widget.orderCustomer!.status ==
                                            StatusOrder.open.name)
                                        ? null
                                        : () {},
                                    child: Text("SELESAI PROSES"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
