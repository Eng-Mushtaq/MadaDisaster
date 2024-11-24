import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/common/styles/spacing_styles.dart';
import 'package:red_zone/features/authentication/screens/login/widgets/login_form.dart';
import 'package:red_zone/features/authentication/screens/login/widgets/login_header.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import 'package:red_zone/utils/constants/text_strings.dart';

import '../../../../common/widgets/login_signup/form_devider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, Title & SubTitle
              const TLoginHeader(),
              // form
              const TLoginForm(),

              TFormDevider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
