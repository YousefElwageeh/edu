import 'package:edu/src/config/utils/AppStrings.dart';
import 'package:edu/src/config/utils/common_widgets/custom_button.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/core/helpers/validators.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/auth_image.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/deafult_rich_text.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/common_widgets/default_text_form_filed.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 02),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      const Logo(),
                      const AuthImage(),
                      verticalSpace(40),
                      CustomTextFormField(
                        label: AppStrings.id,
                        obscureText: false,
                        validator: Valdiator.validateEmptyField(AppStrings.id),
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        label: AppStrings.password,
                        obscureText: false,
                        validator: Valdiator.validatePassword,
                      ),
                      verticalSpace(40),
                      CustomButton(
                          text: AppStrings.signInButton,
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              context.goTo(Routes.layoutRoute);
                            }
                          }),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: defaultRichText(
                      onTap: () => context.goTo(Routes.registerRoute),
                      text1: AppStrings.dontHaveAccount,
                      text2: AppStrings.signUpButton))
            ],
          ),
        ),
      ),
    );
  }
}
