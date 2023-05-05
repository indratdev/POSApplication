import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/export_model.dart';
import 'package:posapplication/module/export.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  int? groupValue = 0;
  List<CategoryModel> listCategory = [];
  List<ItemsModel> listItem = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Pesanan"),
        centerTitle: true,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is SuccessGetItemsByCategory) {
            listItem = state.resultModel;
          }
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SuccessGetAllCategory) {
                List<CategoryModel> listCategoryData = state.resultModel;

                return Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.grey.shade400,
                        child: ListView.builder(
                          itemCount: listCategoryData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            CategoryModel data = listCategoryData[index];
                            return InkWell(
                              onTap: () {
                                print("tap : ${data.categoryName}");
                                BlocProvider.of<OrdersBloc>(context).add(
                                    GetItemByCategoryID(
                                        categoryID: data.categoryID));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Text(data.categoryName),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    //list data
                    Flexible(
                      flex: 12,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 8, bottom: 4, top: 4),
                        shrinkWrap: true,
                        itemCount: listItem.length,
                        itemBuilder: (context, index) {
                          ItemsModel data = listItem[index];
                          return Text(data.itemName);
                        },
                      ),
                    ),
                    //footer
                    Flexible(
                      flex: 1,
                      child: Container(
                        // height: 50,
                        // width: double.infinity,
                        child: Row(
                          children: [
                            Text("Item : 3"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "| Bayar ",
                              style: TextStyle(
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("Rp. 120.000")),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
