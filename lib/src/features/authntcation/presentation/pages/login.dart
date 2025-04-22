import 'package:edu/src/config/utils/AppStrings.dart';
import 'package:edu/src/config/utils/common_widgets/custom_button.dart';
import 'package:edu/src/core/app states/app_states.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/core/helpers/validators.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/authntcation/presentation/cubit/authntcation_cubit.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/auth_image.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/deafult_rich_text.dart';
import 'package:edu/src/features/authntcation/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/utils/common_widgets/default_text_form_filed.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
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
                          textEditingController: studentIdController,
                          label: AppStrings.id,
                          obscureText: false,
                          validator:
                              Valdiator.validateEmptyField(AppStrings.id),
                        ),
                        verticalSpace(20),
                        CustomTextFormField(
                          textEditingController: passwordController,
                          label: AppStrings.password,
                          obscureText: false,
                          validator: Valdiator.validatePassword,
                        ),
                        verticalSpace(40),
                        BlocBuilder<AuthntcationCubit, AuthntcationState>(
                          builder: (context, state) {
                            return state is AuthntcationLoading
                                ? AppStates.LodaingState()
                                : CustomButton(
                                    text: AppStrings.signInButton,
                                    onPressed: () {
                                      if (loginFormKey.currentState!
                                          .validate()) {
                                        context.read<AuthntcationCubit>().login(
                                              studentId:
                                                  studentIdController.text,
                                              password: passwordController.text,
                                              context: context,
                                            );
                                      }
                                    });
                          },
                        ),
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
      ),
    );
  }
}
