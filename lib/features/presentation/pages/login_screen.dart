import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/presentation/bloc/login_cubit.dart';
import 'package:eminencetel/features/presentation/pages/home/navigation_drawer_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_text_field_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/text_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {


    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>()..isUserAlreadyLoggedIn(),
      child: BlocBuilder<LoginCubit, DataState<LoginModel>>(
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.isFailure) {
              final snackBar = SnackBar(content: Text("${state.error}"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            } else if (state.isSuccess) {
              Navigator.popAndPushNamed(context, NavigationDrawerScreen.id);
            }
          });
          return Scaffold(
              body: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleStrings.login_screen_title,
                        style: CustomTextStyles.bold40(),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextFieldWidget(
                        hint: LocaleStrings.login_screen_input_email_hint,
                        icon: Icon(Icons.email, color: CustomColors.black),
                        textInputType: TextInputType.emailAddress,
                        onSave: (p0) {

                        },
                        textEditingController: emailController,
                        validator: (email) {
                          return TextUtils.validateEmail(email!);
                        }),
                    const SizedBox(height: 10),
                    CustomTextFieldWidget(
                        hint: LocaleStrings.login_screen_input_password_hint,
                        icon: Icon(Icons.lock, color: CustomColors.black),
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        textEditingController: passwordController,
                        validator: (password) {
                          return TextUtils.validatePassword(password!);
                        }),
                    const SizedBox(height: 10),
                    CustomButton(
                        buttonColor: CustomColors.blue,
                        text: LocaleStrings.login_screen_button_label,
                        isLoading: state.isInProgress,
                        onClick: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<LoginCubit>().login(emailController.text,passwordController.text);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
