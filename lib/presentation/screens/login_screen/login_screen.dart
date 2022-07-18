import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/auth_wrapper/auth_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/pngs/innovate-tagline.png",
                width: defaultPaddingLarge * 10,
              ),
              defaultSpacerLarge,
              Image.asset(
                "assets/pngs/letsunfold-tagline.png",
                width: defaultPadding * 10,
              ),
            ],
          )),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: defaultPaddingLarge * 15,
                      minWidth: defaultPaddingLarge * 10),
                  child: Form(
                    key: authController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/pngs/logo-text.png",
                          width: defaultPaddingLarge * 10,
                        ),
                        TextFormField(
                          controller: authController.usernameController,
                          decoration:
                              const InputDecoration(label: Text("Username")),
                          validator: (value) => value!.isEmpty
                              ? "Please enter your username"
                              : null,
                        ),
                        AnimatedBuilder(
                            animation: authController,
                            builder: (context, child) {
                              return TextFormField(
                                obscureText: authController.obscureText,
                                validator: (value) => value!.isEmpty
                                    ? "Please enter your password"
                                    : value.length < 6
                                        ? "Please enter a valid password"
                                        : null,
                                controller: authController.passwordController,
                                decoration: InputDecoration(
                                    label: const Text("Password"),
                                    suffixIcon: IconButton(
                                        onPressed: authController
                                            .changePasswordVissibility,
                                        icon: Icon(authController.obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off))),
                                onFieldSubmitted: (value) =>
                                    authController.login(),
                              );
                            }),
                        defaultSpacerLarge,
                        AnimatedBuilder(
                            animation: authController,
                            builder: (context, child) {
                              return ElevatedButton(
                                  onPressed: authController.buttonLoading
                                      ? null
                                      : authController.login,
                                  child: const Text("Login"));
                            }),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
