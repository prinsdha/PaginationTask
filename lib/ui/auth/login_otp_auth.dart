import 'package:demotask/core/constant/app_color.dart';
import 'package:demotask/core/constant/app_settings.dart';
import 'package:demotask/core/service/firebase_service.dart';
import 'package:demotask/core/utils/app_functions.dart';
import 'package:demotask/core/utils/config.dart';
import 'package:demotask/ui/auth/controller/mobile_otp_controller.dart';
import 'package:demotask/ui/home_screen/home_screen.dart';
import 'package:demotask/ui/shared/custom_textfield.dart';
import 'package:demotask/ui/shared/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginOtpScreen extends StatelessWidget {
  static const String routeName = "/loginOtpScreen";
  LoginOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        builder: (MobileOtpController controller) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  "Login with Mobile Number",
                  style: TextStyle(
                      fontSize: getWidth(18), fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomAppTextField(
                    textEditingController: controller.mobileNumber,
                    textFieldType: TextFieldType.mobileNumber),
                controller.isOtpFiledShown
                    ? const SizedBox()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              disposeKeyboard();

                              if (controller.mobileNumber.text.trim().length ==
                                  10) {
                                controller.validateForm();
                              } else {
                                flutterToast("Invalid mobile number");
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Get OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                controller.isOtpFiledShown
                    ? GetBuilder(
                        builder: (MobileOtpController controller) => Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CustomAppTextField(
                                textEditingController: controller.otp,
                                textFieldType: TextFieldType.otpType),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                disposeKeyboard();
                                if (controller.otp.text.trim().length == 6) {
                                  controller.codeVerify();
                                } else {
                                  flutterToast("Invalid OTP");
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
