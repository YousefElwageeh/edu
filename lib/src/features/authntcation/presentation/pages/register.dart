import 'package:edu/src/config/theme/styles.dart';
import 'package:edu/src/config/utils/AppStrings.dart';
import 'package:edu/src/config/utils/assetsManger.dart';
import 'package:edu/src/config/utils/common_widgets/custom_button.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/core/helpers/validators.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/auth_image.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/common_widgets/default_text_form_filed.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController idText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

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
                  key: registerFormKey,
                  child: Column(
                    children: [
                      const Logo(),
                      const AuthImage(),
                      verticalSpace(40),
                      CustomTextFormField(
                          textEditingController: idText,
                          label: AppStrings.id,
                          obscureText: false,
                          validator:
                              Valdiator.validateEmptyField(AppStrings.id)),
                      verticalSpace(20),
                      CustomTextFormField(
                          textEditingController: passwordText,
                          label: AppStrings.password,
                          obscureText: false,
                          validator: Valdiator.validatePassword),
                      verticalSpace(20),
                      CustomTextFormField(
                        textEditingController: confirmPasswordText,
                        label: AppStrings.rePassword,
                        obscureText: false,
                        validator: (confirmPassword) =>
                            Valdiator.validateConfirmPassword(
                                passwordText.text, confirmPassword),
                      ),
                      verticalSpace(40),
                      CustomButton(
                          text: AppStrings.signInButton,
                          onPressed: () {
                            if (registerFormKey.currentState!.validate()) {}
                          }),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: font16BlackRegular,
                    ),
                    TextButton(
                        onPressed: () {
                          context.goTo(Routes.loginScreen);
                        },
                        child: Text(
                          AppStrings.signInButton,
                          style: font16Purpleregular,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
