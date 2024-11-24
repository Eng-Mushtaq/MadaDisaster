import 'package:get/get.dart';

// A utility class for managing a full-screen loading dialog.
import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/loaders/animation_loader.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

class TFullScreenLoader {
  // Open a full screen loading dialog with a given text a given text and animation.
  // This method doesn't return anything.
  //
  // Parameters:
  // - [text] (required): The text to be displayed in the dialog.
  // - [animation] (required): The path to the Lottie animation file.
  static void openLoadingDialog({required String text, required String animation}) {
    // TODO: Add implementation
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside of the dialog
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.light,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust the height of the dialog
              TAnimationLoaderWidget(text: text, animation: animation)
            ],
          ),
        ),
      ),
    );
  }

  // Close the full screen loading dialog.
  // This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the Navigator
  }
}
