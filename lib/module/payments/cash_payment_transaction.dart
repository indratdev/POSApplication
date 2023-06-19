import 'package:flutter/material.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';

import '../../../data/model/orders_model.dart';
import '../../../shared/widgets/export_widget.dart';
import '../../shared/constants/constants.dart';

class CashPaymentTransactionScreen extends StatefulWidget {
  OrdersModel? orderCustomer;
  double totalTranscationAmount;

  CashPaymentTransactionScreen({
    super.key,
    this.orderCustomer,
    required this.totalTranscationAmount,
  });

  @override
  State<CashPaymentTransactionScreen> createState() =>
      _CashPaymentTransactionScreenState();
}

class _CashPaymentTransactionScreenState
    extends State<CashPaymentTransactionScreen> {
  final Map<String, dynamic> detailOrder = {};
  List<Map<String, dynamic>> finalItem = [];
  String totalPayment = "0";

  @override
  void initState() {
    super.initState();
  }

  // Future loadDataTransaction() async {
  //   Map<String, dynamic> jumlahHargaMap = {};
  //   List<Map<String, dynamic>> result = [];
  //   double grandTotal = 0.0;

  //   for (var item in widget.orderCustomer!.dataItem!) {
  //     String itemName = item.itemName;
  //     double sellPrice = item.sellPrice;

  //     if (jumlahHargaMap.containsKey(itemName)) {
  //       jumlahHargaMap[itemName]['quantity'] += 1;
  //       jumlahHargaMap[itemName]['totalPrice'] += sellPrice;
  //     } else {
  //       jumlahHargaMap[itemName] = {
  //         'quantity': 1,
  //         'totalPrice': sellPrice,
  //       };
  //     }
  //   }

  //   jumlahHargaMap.forEach((key, value) {
  //     int quantity = value['quantity'];
  //     double totalPrice = value['totalPrice'];
  //     grandTotal += totalPrice;

  //     // print('Nama: $key, Jumlah: $quantity, Total Harga: $totalPrice');
  //     result.add({
  //       "itemName": key,
  //       "quantity": quantity,
  //       "totalPrice": totalPrice,
  //     });
  //   });

  //   result.add({"grandTotal": grandTotal});

  //   // print(result);
  //   // print(">>>>> grand total : $grandTotal");
  //   return result;
  // }

  // typePayment(String number) {
  //   print(number);

  //   List<String> amount = totalPayment.toString().split('');

  //   if (totalPayment == "0") {
  //     print("true");
  //     amount = [];
  //     // amount[0] = number;
  //     amount.add(number);
  //   } else {
  //     amount.add(number);
  //   }

  //   print(">>> amount[0] : ${amount[0]}");
  //   print(">>> amount : ${amount}");

  //   setState(() {
  //     totalPayment = (amount.join(""));
  //     print(">>> totalPayment : $totalPayment");
  //   });
  // }

  typePayment(String number) {
    if (totalPayment == "0") {
      totalPayment = number;
    } else {
      totalPayment += number;
    }
    setState(() {});
  }

  clearPayment() {
    print(">>> clearPayment running : ${totalPayment}");

    String result = totalPayment.substring(0, totalPayment.length - 1);

    if (result == "") {
      totalPayment = "0";
    } else {
      totalPayment = result;
    }

    setState(() {});
  }

  Widget _buildNumberButton(BuildContext context, String number) {
    return ElevatedButton(
      // onPressed: () => typePayment(number),
      onPressed: () {
        if (number == "C") {
          clearPayment();
        } else {
          typePayment(number);
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width / 6,
            MediaQuery.of(context).size.width / 6),
        shape: CircleBorder(),
        padding: EdgeInsets.all(24),
      ),
      child: Text(number.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran Cash / Tunai"),
        centerTitle: true,
      ),
      body: Container(
        // padding: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Tagihan"),
                Text(
                  "Rp. ${widget.totalTranscationAmount}",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text("Total Bayar"),
                  Text(
                    totalPayment,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "* pastikan jumlah yang dimasukan sesuai dengan uang yang anda terima",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 38,
                    color: blackOpacity06TextColor,
                  ),
                ),
                Text(
                  "** tekan untuk memasukan jumlah uang yang dibayarkan",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 38,
                    color: blackOpacity06TextColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(8),
              color: lightPeachColor,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNumberButton(context, "1"),
                            _buildNumberButton(context, "2"),
                            _buildNumberButton(context, "3"),
                            _buildNumberButton(context, "C"),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.backspace),
                            // )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNumberButton(context, "4"),
                            _buildNumberButton(context, "5"),
                            _buildNumberButton(context, "6"),
                            _buildNumberButton(context, "00"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNumberButton(context, "7"),
                            _buildNumberButton(context, "8"),
                            _buildNumberButton(context, "9"),
                            _buildNumberButton(context, "0"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text("KEMBALI"),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      print("====================");

                      var ress = double.parse(totalPayment) -
                          widget.totalTranscationAmount;
                      print(
                          "${double.parse(totalPayment)} - ${widget.totalTranscationAmount} = $ress");

                      print("====================");
                    },
                    child: Text("BAYAR"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
