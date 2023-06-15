import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';

import '../../../data/model/export_model.dart';
import '../../../data/model/orders_model.dart';
import '../../../shared/widgets/export_widget.dart';

class PayOrderScreen extends StatefulWidget {
  OrdersModel? orderCustomer;

  PayOrderScreen({
    super.key,
    this.orderCustomer,
  });

  @override
  State<PayOrderScreen> createState() => _PayOrderScreenState();
}

class _PayOrderScreenState extends State<PayOrderScreen> {
  final Map<String, dynamic> detailOrder = {};
  List<Map<String, dynamic>> finalItem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // finalItem = awaw fillDetail();
  }

  // fillDetail() {
  //   // var aaa = widget.orderCustomer!.dataItem;
  //   // for (var element in widget.orderCustomer.dataItem) {
  //   List<ItemsModel>? itemList = widget.orderCustomer!.dataItem;

  //   // for (var element in itemList!) {
  //   //   print(element.toJson());
  //   // }

  //   if (itemList != null) {
  //     for (var data in itemList) {
  //       if (detailOrder.containsKey(data.itemName)) {
  //         detailOrder[data.itemName] = detailOrder[data.itemName]! + 1;
  //       } else {
  //         detailOrder[data.itemName] = 1;
  //       }
  //     }
  //   }
  //   // }
  //   detailOrder.forEach((key, value) {
  //     print("value : ${value} - ${key}");
  //   });
  // }
  // Future<List<Map<String, dynamic>>>
  Future loadDataTransaction() async {
    Map<String, dynamic> jumlahHargaMap = {};
    List<Map<String, dynamic>> result = [];
    double grandTotal = 0.0;

    for (var item in widget.orderCustomer!.dataItem!) {
      String itemName = item.itemName;
      double sellPrice = item.sellPrice;

      if (jumlahHargaMap.containsKey(itemName)) {
        jumlahHargaMap[itemName]['quantity'] += 1;
        jumlahHargaMap[itemName]['totalPrice'] += sellPrice;
      } else {
        jumlahHargaMap[itemName] = {
          'quantity': 1,
          'totalPrice': sellPrice,
        };
      }
    }

    jumlahHargaMap.forEach((key, value) {
      int quantity = value['quantity'];
      double totalPrice = value['totalPrice'];
      grandTotal += totalPrice;

      // print('Nama: $key, Jumlah: $quantity, Total Harga: $totalPrice');
      result.add({
        "itemName": key,
        "quantity": quantity,
        "totalPrice": totalPrice,
      });
    });

    result.add({"grandTotal": grandTotal});

    // print(result);
    // print(">>>>> grand total : $grandTotal");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran Transaksi"),
        centerTitle: true,
      ),
      body: Container(
        // padding: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Nota Pemesanan"),
            const SeparatorDashWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Nama Pelanggan :"),
                // const SizedBox(width: 10),
                Text(widget.orderCustomer?.dataCustomer?.fullname ?? "",
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("No. Meja :"),
                // const SizedBox(width: 10),
                Text(widget.orderCustomer?.dataTable?.tableNo ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dibuat oleh :"),
                Text(widget.orderCustomer?.addBy ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tgl/waktu Pesan :"),
                Text(DateUtil.convertToDayAndDateTimeFull(
                    widget.orderCustomer?.dateTimeOrder! ?? DateTime.now())),
              ],
            ),
            const SeparatorDashWidget(),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: 100,
            //   itemBuilder: (context, index) {
            //     return Text("dasss");
            //   },
            // )
            Expanded(
              child: FutureBuilder(
                future: loadDataTransaction(),
                builder: (context, snapshot) {
                  // 1 . // WHILE THE CALL IS BEING MADE AKA LOADING
                  if (ConnectionState.active != null && !snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  // 2. // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
                  if (ConnectionState.done != null && snapshot.hasError) {
                    return const Center(child: Text('Something went wrong :('));
                  }

                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<Map<String, dynamic>> datas = snapshot.data;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: datas.length - 1,
                          // itemCount: 30,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = datas[index].entries;
                            // print(data[index].entries.elementAt(1));
                            // return Text(
                            //     "${data.elementAt(0).value} (${data.elementAt(1).value}x)  ");
                            return ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.all(0),
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              title: Text(
                                  "${data.elementAt(0).value} (${data.elementAt(1).value}x)  "),
                              // title: Text(data[index]["itemName"]),
                              trailing:
                                  Text(data.elementAt(2).value.toString()),
                              // title: Text("datasssss"),
                            );
                          },
                        ),
                        const SeparatorDashWidget(),
                        const SizedBox(height: 15),
                        Text(
                          "TOTAL :  ${datas.last.entries.first.value.toString()}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            // fontSize: 14,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.wallet_outlined),
                                          title: Text('Tunai / Cash'),
                                          subtitle:
                                              Text("Menggunakan uang tunai"),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.wallet_outlined),
                                          title: Text('Tunai / Cash'),
                                          subtitle:
                                              Text("Menggunakan uang tunai"),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                        ),
                                        // ListTile(
                                        //   leading: Icon(Icons.copy),
                                        //   title: Text('Copy Link'),
                                        // ),
                                        // ListTile(
                                        //   leading: Icon(Icons.edit),
                                        //   title: Text('Edit'),
                                        // ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("BAYAR"),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return const Center(
                      child: CircularProgressIndicator.adaptive());

                  // if (snapshot.hasData) {
                  //   List<Map<String, dynamic>> data = snapshot.data;
                  //   print(">>>> data : ${data}");
                  //   ListView.builder(
                  //     shrinkWrap: true,
                  //     // itemCount: detailOrder.length,
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       // String key = detailOrder.keys.elementAt(index);
                  //       // int value = detailOrder[key]!;
                  //       // print("${data[index].keys}");
                  //       return ListTile(
                  //         dense: true,
                  //         contentPadding: const EdgeInsets.all(0),
                  //         visualDensity:
                  //             const VisualDensity(horizontal: 0, vertical: -4),
                  //         title: Text("tesss"),
                  //         // title: Text(data[index]["itemName"]),
                  //         // trailing: Text(value.toString()),
                  //       );
                  //     },
                  //   );
                  // } else {
                  //   return Center(child: CircularProgressIndicator());
                  // }

                  // return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
