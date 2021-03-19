import 'package:get/get.dart';
import 'package:flutter/material.dart';




import 'package:ru_agenda/app/routes/app_pages.dart';
import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/widgets/rounded_button.widget.dart';
import 'package:ru_agenda/app/widgets/rounded_input_field.widget.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/main_logo.png',
                  width: 200,
                ),
                SizedBox(height: 50),
                RoundedInputField(
                  hintText: 'Username',
                  prefixIcon: Icons.person_rounded,
                  maxLines: 1,
                ),
                SizedBox(height: 5),
                RoundedInputField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_rounded,
                  maxLines: 1,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                RoundedButton(
                  onPressed: () {
                    Get.toNamed(Routes.HOME);
                  },
                  height: 45,
                  width: Get.width,
                  color: kPrimaryLightColor,
                  textContent: 'LOGIN',
                  textColor: kPrimaryColor,
                ),
                SizedBox(height: 20),
                Text(
                  'Forgot password?',
                  style: TextStyle(color: kPrimaryLightColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
