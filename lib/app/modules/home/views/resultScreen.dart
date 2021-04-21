import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrap_bid/app/data/constants.dart';
import 'package:scrap_bid/app/modules/detailView/controllers/detail_view_controller.dart';
import 'package:scrap_bid/app/modules/home/controllers/home_controller.dart';
import 'package:scrap_bid/app/modules/home/result_response_model.dart';
import 'package:scrap_bid/app/modules/login/views/login_view.dart';
import 'package:scrap_bid/app/routes/app_pages.dart';

class ResultScrenn extends GetView<HomeController> {
  ResultResponseModel response;

  ResultScrenn(this.response);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.APP_THEME_COLOR,
        centerTitle: true,
        title: Text("Result", style: GoogleFonts.montserrat(fontSize: 20)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/winner.png"),
              ),
            ),
            SizedBox(
              height: Get.height / 10,
            ),
            Text(
              response.msg,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
            Spacer(),
            MainButton(
              title: "Continue",
              onPress: () {
                Get.offAndToNamed(Routes.HOME);
              },
            ),
          ],
        ),
      ),
    );
  }
}