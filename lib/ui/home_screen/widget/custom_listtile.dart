import 'package:demotask/core/constant/app_color.dart';
import 'package:demotask/core/utils/config.dart';
import 'package:demotask/ui/home_screen/controller/home_controller.dart';
import 'package:demotask/ui/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController homeController) => RefreshIndicator(
        onRefresh: () async {
          homeController.isFetching = false;
          await homeController.fetchNextData();
        },
        child: ListView(
          controller: homeController.scrollController,
          children: homeController.fetchAllData
              .asMap()
              .map((index, data) => MapEntry(
                  index,
                  Column(
                    children: [
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColor.kPrimaryFontColor
                                        .withOpacity(0.20)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Icon(
                                Icons.book_sharp,
                                size: getWidth(40),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.name),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data.description,
                                    style: TextStyle(
                                        color: AppColor.kPrimaryFontColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      pairOfIconNText(
                                          iconData: Icons.code,
                                          text: data.language),
                                      pairOfIconNText(
                                          iconData: Icons.bug_report,
                                          text: data.stargazersCount),
                                      pairOfIconNText(
                                          iconData: Icons.face,
                                          text: data.watchersCount),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: (index + 1) == homeController.fetchAllData.length
                            ? homeController.isFetching
                                ? getLoader()
                                : const SizedBox()
                            : const SizedBox(),
                      )
                    ],
                  )))
              .values
              .toList(),
        ),
      ),
    );
  }

  Padding pairOfIconNText({required IconData iconData, dynamic text}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 3,
          ),
          Text(
            "$text",
            style: TextStyle(color: AppColor.kPrimaryFontColor),
          )
        ],
      ),
    );
  }
}
