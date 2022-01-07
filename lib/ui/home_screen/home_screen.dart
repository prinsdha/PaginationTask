import 'package:demotask/ui/home_screen/controller/home_controller.dart';
import 'package:demotask/ui/home_screen/widget/custom_listtile.dart';
import 'package:demotask/ui/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: customListTile(),
    );
  }

  GetBuilder<HomeController> customListTile() {
    return GetBuilder(
      builder: (HomeController homeController) =>
          homeController.isLoaderForFullScreen
              ? Center(child: getLoader())
              : homeController.fetchAllData.isEmpty
                  ? refreshView(homeController)
                  : const CustomListTile(),
    );
  }

  GestureDetector refreshView(HomeController homeController) {
    return GestureDetector(
        onTap: () {
          homeController.isFetching = false;
          homeController.fetchData();
        },
        child: Container(
            color: Colors.transparent,
            child: const Center(child: Text("No data found, Tap to refresh"))));
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: false,
      title: const Text("Jake's Git"),
    );
  }
}
