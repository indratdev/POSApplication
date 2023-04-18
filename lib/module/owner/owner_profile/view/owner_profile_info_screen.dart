import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
// import 'package:posapplication/module/owner/owner_profile/controller/profile_controller.dart';
import 'package:posapplication/module/owner/owner_profile/view/widgets/profile_widget.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../../../data/model/profile_model.dart';
import '../../../../data/service/hive_service/hive_service.dart';

class OwnerProfileInfoScreen extends StatefulWidget {
  const OwnerProfileInfoScreen({super.key});

  @override
  State<OwnerProfileInfoScreen> createState() => _OwnerProfileInfoScreenState();
}

class _OwnerProfileInfoScreenState extends State<OwnerProfileInfoScreen> {
  // final ProfileController controller = ProfileController();
  late final Box box;
  // bool hasDataProfile = false;

  @override
  void dispose() {
    print(">> dispose run OwnerProfileInfoScreen");
    Hive.close();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  // openBoxx() async {
  //   box = await Hive.openBox<ProfileModel>(HiveService.companyProfileBox);
  // }

  // Future<Box> openBoxProfile() async {
  //   var resultBox = await controller.isBoxProfileAlreadyOpen();
  //   box = resultBox;
  //   return resultBox;
  // }

  @override
  Widget build(BuildContext context) {
    // ProfileModel dummy = ProfileModel(bussinessName: "testt");
    return BlocBuilder<OwnerBloc, OwnerState>(
      builder: (context, state) {
        print(">>>> state ::: ${state}");
        // if (state is LoadingReadProfileCompany) {
        //   return CustomWidgets.showLoadingWidgetContainer(context);
        // }
        if (state is FailureReadProfileCompany) {
          return Scaffold(
            body: Center(child: Text(state.messageError.toString())),
          );
        }
        if (state is SuccessReadProfileCompany) {
          var datas = state.dataBox;

          // kalau kosong
          if (datas.isEmpty) {
            return ProfileWidget(
              isUpdate: false,
            );
          } else {
            ProfileModel profile = datas.values.first;
            return ProfileWidget(
              isUpdate: true,
              profileModel: profile,
            );
          }
        } else {
          return SizedBox();
        }
        // return ProfileWidget(
        //   isUpdate: true,
        //   profileModel: dummy,
        // );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: openBoxProfile(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Scaffold(
  //           body: Center(
  //             heightFactor: MediaQuery.of(context).size.height,
  //             child: const CircularProgressIndicator.adaptive(),
  //           ),
  //         );
  //       }
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         var resultData = snapshot.data?.values;

  //         if (snapshot.hasError) {
  //           return Scaffold(
  //             appBar: AppBar(),
  //             body: Center(
  //               heightFactor: MediaQuery.of(context).size.height,
  //               child: const Text("Ada Kesalahan, Mohon Ulangin Kembali"),
  //             ),
  //           );
  //         }
  //         if (resultData!.isEmpty) {
  //           return ProfileWidget(
  //             isUpdate: false,
  //           );
  //         }
  //         if (snapshot.hasData) {
  //           ProfileModel profile = snapshot.data!.values.first;
  //           return ProfileWidget(
  //             isUpdate: true,
  //             profileModel: profile,
  //           );
  //         } else {
  //           return Scaffold(
  //             appBar: AppBar(),
  //             body: Center(
  //               child: Text("Tidak Ada Data"),
  //             ),
  //           );
  //         }
  //       } else {
  //         return SizedBox();
  //       }
  //     },
  //   );
  // }
}
