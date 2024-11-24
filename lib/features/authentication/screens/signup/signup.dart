import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:red_zone/common/widgets/login_signup/form_devider.dart';
import 'package:red_zone/common/widgets/login_signup/social_buttons.dart';
import 'package:red_zone/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import 'package:red_zone/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              const TSignupForm(),

              const SizedBox(height: TSizes.spaceBtwSections),
              // divider
              TFormDevider(dividerText: TTexts.orSignUpWith.capitalize!),

              const SizedBox(height: TSizes.spaceBtwSections),
              // Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
