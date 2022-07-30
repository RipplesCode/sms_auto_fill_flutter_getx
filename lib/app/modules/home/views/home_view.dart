import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP View'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Obx(
            () => PinFieldAutoFill(
              textInputAction: TextInputAction.done,
              controller: controller.otpEditingController,
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                colorBuilder: const FixedColorBuilder(
                  Colors.transparent,
                ),
                bgColorBuilder: FixedColorBuilder(
                  Colors.grey.withOpacity(0.2),
                ),
              ),
              currentCode: controller.messageOtpCode.value,
              onCodeSubmitted: (code) {},
              onCodeChanged: (code) {
                controller.messageOtpCode.value = code!;
                controller.countdownController.pause();
                if (code.length == 6) {
                  // To perform some operation
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Countdown(
            controller: controller.countdownController,
            seconds: 15,
            interval: const Duration(milliseconds: 1000),
            build: (context, currentRemainingTime) {
              if (currentRemainingTime == 0.0) {
                return GestureDetector(
                  onTap: () {
                    // write logic here to resend OTP
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 14, bottom: 14),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.blue, width: 1),
                        color: Colors.blue),
                    width: context.width,
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  width: context.width,
                  child: Text(
                      "Wait |${currentRemainingTime.toString().length == 4 ? " ${currentRemainingTime.toString().substring(0, 2)}" : " ${currentRemainingTime.toString().substring(0, 1)}"}",
                      style: const TextStyle(fontSize: 16)),
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}
