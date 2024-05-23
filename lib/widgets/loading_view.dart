import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mynewpackage/widgets/please_wait_dialogue.dart';


class LoadingView extends StatelessWidget {
   const LoadingView(
      {super.key,
        required this.isAsyncCall,
        required this.child,
        required this.showBackGroundData,
        this.backGroundColor,
        required this.authenticated,
      });
  final RxBool isAsyncCall, authenticated;
  final Widget child;
  final bool showBackGroundData;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => LoadingOverlay(
        color: backGroundColor ?? Colors.white,
        isLoading: isAsyncCall.value,
        opacity: isAsyncCall.value ? 0.5 : 0.1,
        progressIndicator: AuthenticationDialog(
          documentsUploaded: authenticated.value,
        ),
        child: showBackGroundData
            ? child
            : !isAsyncCall.value
            ? child
            : Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
