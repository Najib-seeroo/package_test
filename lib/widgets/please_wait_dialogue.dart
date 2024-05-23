import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../app_colors.dart';
import '../size_utils.dart';



class AuthenticationDialog extends StatelessWidget {
  const AuthenticationDialog({super.key, this.documentsUploaded = false});

  final bool documentsUploaded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Wrap(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.backgroundColor),
                    width: documentsUploaded ? loaderBackground : Get.width,
                    child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SpinKitRing(
                        color: AppColors.primaryColor,
                        size: 40,
                        lineWidth: 3,
                      ),
                      documentsUploaded ? SizedBox() : SizedBox(width: marginTimer),
                      documentsUploaded
                          ? SizedBox()
                          : const Expanded(
                        child: Text(
                          "Please Wait...",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                        ),
                      ),
                    ])))
          ])),
    );
  }
}
