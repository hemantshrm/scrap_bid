import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrap_bid/app/data/constants.dart';
import 'package:scrap_bid/app/modules/detailView/views/submit_bid_view.dart';
import 'package:scrap_bid/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  Future<bool> _onWillPop() {
    return Get.defaultDialog(
          radius: 5,
          title: 'Are you sure?',
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Get.back(),
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Yes'),
            ),
          ],
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Auctions', style: GoogleFonts.montserrat(fontSize: 20)),
          centerTitle: true,
          backgroundColor: AppConstants.APP_THEME_COLOR,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: () {},
            ),
          ],
        ),
        drawer: HomeDrawer(),
        body: controller.obx(
          (state) => ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) => Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
              itemCount: controller.apiData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(controller.apiData[index].id);
                    Get.toNamed(Routes.DETAIL_VIEW,
                        arguments: controller.apiData[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  spacing: 20,
                                  children: [
                                    // Container(
                                    //   height: 20,
                                    //   child: Text(
                                    //     "Auction",
                                    //     textAlign: TextAlign.center,
                                    //     style: AppConstants.dashboardStyle
                                    //         .copyWith(
                                    //             color:
                                    //                Colors.black,
                                    //             fontSize: 20),
                                    //   ),
                                    // ),
                                    Container(
                                      height: 20,
                                      child: Text(
                                          '${controller.apiData.value[index].materialCode}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  AppConstants.APP_THEME_COLOR,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${controller.apiData.value[index].materialDescription}',
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppConstants.dashboardStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "End Date :",
                                      style: AppConstants.dashboardStyle
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color:
                                                  AppConstants.APP_THEME_COLOR),
                                    ),
                                    Text(
                                      '${controller.apiData.value[index].auctionCloseDate}',
                                      style: AppConstants.dashboardStyle
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppConstants.APP_THEME_COLOR,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }),
          onLoading: Center(child: CircularProgressIndicator()),
          onEmpty: Text('No data found'),
          onError: (error) => Text(error),
        ),
      ),
    );
  }
}

class HomeDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppConstants.APP_THEME_COLOR),
            accountName: controller.userData.value != null
                ? Text(controller.userData.value.fullname,
                    style: GoogleFonts.montserrat(fontSize: 16))
                : Text("Login Please"),
            accountEmail: controller.userData.value != null
                ? Text(controller.userData.value.email,
                    style: GoogleFonts.montserrat(fontSize: 16))
                : Text("Login Please"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? AppConstants.APP_THEME_COLOR
                  : Colors.white,
              child: Text(
                "${controller.userData.value.fullname[0]}",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: TileText('Auction Result'),
            leading: Icon(
              Icons.receipt,
              color: AppConstants.APP_THEME_COLOR,
            ),
            onTap: () {
              controller.getResult(context);
              Get.back();
            },
          ),
          Divider(
            indent: 40,
          ),
          ListTile(
            title: TileText('Sign Out'),
            leading: Icon(Icons.logout, color: AppConstants.APP_THEME_COLOR),
            onTap: () async {
              await controller.clearPrefs();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }   //abha1281
}

class TileText extends StatelessWidget {
  const TileText(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: GoogleFonts.montserrat(fontSize: 16));
  }
}
