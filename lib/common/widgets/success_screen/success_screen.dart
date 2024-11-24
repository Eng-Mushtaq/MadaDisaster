import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:red_zone/common/styles/spacing_styles.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';
import '../../../utils/constants/text_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.animation, required this.title, required this.subTitle, required this.onpressed});

  final String animation, title, subTitle;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.6),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Title & SubTitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: onpressed, child: const Text(TTexts.tContinue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
