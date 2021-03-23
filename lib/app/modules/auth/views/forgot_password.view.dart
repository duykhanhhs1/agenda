import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import 'package:gm_pms/app/widgets/form_rounded_input_field.widget.dart';
import 'package:gm_pms/app/modules/auth/controllers/forgot_password.controller.dart';
import 'package:gm_pms/app/widgets/rounded_button.widget.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                    "Submit your email address and we’ll send you a new password."),
                SizedBox(height: 20),
                FormRoundedInputField(
                  controller: controller.emailController,
                  iconPrefix: Icons.email,
                  hintText: 'Input your email',
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'Email is required'),
                      EmailValidator(errorText: 'Invalid email'),
                    ],
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) => controller.emailController.text = value,
                ),
                SizedBox(height: 20),
                RoundedButton(
                  labelText: "Reset Password",
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      controller.forgotPassword();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
