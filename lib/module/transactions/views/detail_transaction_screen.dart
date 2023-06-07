import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/data/model/users_model.dart';

import 'package:posapplication/module/transactions/widgets/status_transaction_widgets.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/routes/app_routes.dart';
import '../../blocs/export_bloc.dart';

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
  List<UsersModel> usersList = [];

  @override
  void initState() {
    checkImageStatus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkImageStatus() {
    if (widget.orderCustomer!.status == StatusOrder.waiting.name) {
      statusMap["image"] = workProcess;
      statusMap["description"] = "Transaksi Sudah Didaftarkan";
    }
    if (widget.orderCustomer!.status == StatusOrder.waiting.name) {
      statusMap["image"] = "";
      statusMap["description"] = "Menunggu";
    }
    if (widget.orderCustomer!.status == StatusOrder.progress.name) {
      statusMap["image"] = check;
      statusMap["description"] = "Transaksi Sedang Diproses";
    }
    if (widget.orderCustomer!.status == StatusOrder.cancel.name) {
      statusMap["image"] = failure;
      statusMap["description"] = "Transaksi Dibatalkan / Gagal";
    }
    if (widget.orderCustomer!.status == StatusOrder.ready.name) {
      statusMap["image"] = excellence;
      statusMap["description"] = "Transaksi Berhasil";
    }
  }

  // continueProcess() {
  //   CustomWidgets.showConfirmation(
  //       context, "Apakah anda ingin melanjutkan proses ini ?", () {
  //     if (widget.orderCustomer != null) {
  //       BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
  //         status: StatusOrder.progress,
  //         orderCustomer: widget.orderCustomer!,
  //       ));
  //     }
  //   });
  // }

  // canceledProcess() {
  //   CustomWidgets.showConfirmation(
  //       context, "Apakah anda ingin membatalkan proses ini ?", () {
  //     if (widget.orderCustomer != null) {
  //       // BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
  //       //   status: StatusOrder.progress,
  //       //   orderCustomer: widget.orderCustomer!,
  //       // ));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    int _widthIcon = _width ~/ 5;

    print("======  ${widget.orderCustomer!.userHandleBy}");

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Transaksi"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocListener<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is SuccessUpdateStatusOrder) {
                CustomWidgets.showMessageAlertWithF(
                    context, "Pesanan berhasil diperbaharui", true, () {
                  // return to dashboard
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.ownerBottomNav, (route) => false);
                });
              }
            },
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is SuccessSelectedUser) {
                  print(">>> state SuccessSelectedUser jalan....");
                  widget.orderCustomer?.userHandleBy = state.user.firstname;
                  widget.orderCustomer?.userHandleID = state.user.userID;
                }

                if (state is SuccessGetAllUserFromBox) {
                  usersList = state.resultModel;
                }
                return BlocListener<OrdersBloc, OrdersState>(
                  listener: (context, state) {
                    if (state is SuccessUpdateStatusOrder) {
                      Navigator.pop(context);
                      CustomWidgets.showMessageAlertWithF(
                          context, state.result, true, () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.ownerBottomNav, (route) => false);
                      });
                    }
                  },
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
                            // table
                            const SizedBox(height: 5),
                            const Text(
                              "No. Meja",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(widget.orderCustomer!.dataTable?.tableName ??
                                "Belum Pilih Meja"),
                          ],
                        ),
                      ),
                      Divider(
                          color: Colors.green.shade200,
                          thickness: 1,
                          height: 1),

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
                                  widget.orderCustomer!.dataCustomer
                                          ?.fullname ??
                                      "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  widget.orderCustomer!.dataCustomer
                                          ?.phoneNumber ??
                                      "",
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
                      Divider(
                          color: Colors.green.shade200,
                          thickness: 1,
                          height: 1),

                      // staff maker
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
                                  "Staff Maker :",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  widget.orderCustomer!.userHandleBy ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          color: Colors.green.shade200,
                          thickness: 1,
                          height: 1),

                      // customer order
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
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        // color: Colors.amber,
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height / 2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                '"Pesanan ini masih dalam status ${widget.orderCustomer?.status ?? ''}" \n Anda dapat melihat catatan untuk kemudahan',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 18),
                              (widget.orderCustomer!.status ==
                                          StatusOrder.cancel.name ||
                                      widget.orderCustomer!.status ==
                                          StatusOrder.waiting.name)
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              (widget.orderCustomer!.status ==
                                                          StatusOrder
                                                              .ready.name ||
                                                      widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .progress.name ||
                                                      widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .ready.name)
                                                  ? Icons.circle
                                                  : Icons.circle_outlined,
                                              color: (widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .waiting.name ||
                                                      widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .progress.name ||
                                                      widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .waiting.name)
                                                  ? Colors.blue
                                                  : null,
                                            ),
                                            Text(StatusOrder.waiting.name
                                                .toUpperCase()
                                                .toString())
                                          ],
                                        ),
                                        const Icon(Icons.maximize),
                                        Column(
                                          children: [
                                            Icon(
                                              // (status == 0)
                                              (widget.orderCustomer!.status ==
                                                      StatusOrder.waiting.name)
                                                  ? Icons.circle_outlined
                                                  : Icons.circle,
                                              color:
                                                  // (status == 0)
                                                  (widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .waiting.name)
                                                      ? null
                                                      : Colors.blue,
                                            ),
                                            Text(StatusOrder.progress.name
                                                .toUpperCase()
                                                .toString())
                                          ],
                                        ),
                                        const Icon(Icons.maximize),
                                        Column(
                                          children: [
                                            Icon(
                                              // (status == 0 || status == 2)
                                              (widget.orderCustomer!.status ==
                                                          StatusOrder
                                                              .waiting.name ||
                                                      widget.orderCustomer!
                                                              .status ==
                                                          StatusOrder
                                                              .progress.name)
                                                  ? Icons.circle_outlined
                                                  : Icons.circle,
                                              color:
                                                  // (status == 0 || status == 2)
                                                  (widget.orderCustomer!
                                                                  .status ==
                                                              StatusOrder
                                                                  .waiting
                                                                  .name ||
                                                          widget.orderCustomer!
                                                                  .status ==
                                                              StatusOrder
                                                                  .progress
                                                                  .name)
                                                      ? null
                                                      : Colors.blue,
                                            ),
                                            Text(
                                              StatusOrder.ready.name
                                                  .toUpperCase()
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 55),

                              // kalau user handlenya kosong harus diisi, kalau sudah ada bisa lanjut ke
                              // proses selanjutnya
                              (widget.orderCustomer?.userHandleBy == "")
                                  ? StatusTransactionWidgets(
                                      orderCustomer: widget.orderCustomer,
                                      statusMap: statusMap,
                                      width: _width,
                                      // usersList: usersList,
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        CustomWidgets.showConfirmation(context,
                                            "Apakah anda yakin melanjutkan proses ini ?",
                                            () {
                                          BlocProvider.of<OrdersBloc>(context)
                                              .add(UpdateStatusOrders(
                                            status: StatusOrder.progress,
                                            orderCustomer:
                                                widget.orderCustomer!,
                                          ));

                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text("Lanjut Proses"))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
