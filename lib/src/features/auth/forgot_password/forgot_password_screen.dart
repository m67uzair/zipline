import 'package:courier_app/src/components/custom_textfield.dart';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import '../auth/auth.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  String countryCode = '91';
  String number = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: margin_15),
            children: [
              CustomDivider(
                height: height_15,
                isDivider: false,
              ),
              Align(
                alignment: Alignment.topLeft,
                child:
                    CustomText(text: strForget, color1: AppColors.white, fontWeight: fontWeight700, fontSize: font_20),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                    text: strForgotPass, color1: AppColors.textWhite, fontWeight: fontWeight400, fontSize: font_11),
              ),
              CustomDivider(
                height: height_30,
                isDivider: false,
              ),
              Image.asset(ImgAssets.forgotArt, height: height_250),
              CustomDivider(
                height: height_40,
                isDivider: false,
              ),
              CustomTextField(
                labelText: strEnterEmail,
                prefixIcon: ImgAssets.emailIcon,
                obscure: false,
                height: height_15,
                controller: emailController,
                textInputType: TextInputType.text,
                validator: ValidationBuilder().required().email().build(),
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  fillColor: AppColors.white.withOpacity(.1),
                  filled: true,
                  labelText: "Enter Phone Number",
                  labelStyle: TextStyle(color:AppColors.white,fontSize: font_14, fontFamily: 'Mukta', fontWeight: fontWeight400),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(color: AppColors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(color: AppColors.white)),
                ),
                dropdownIcon: Icon(Icons.arrow_drop_down,color: AppColors.white,),
                dropdownTextStyle: TextStyle(color: AppColors.white),
                style: TextStyle(color: AppColors.orange),
                initialCountryCode: 'IN',
                onCountryChanged: (phone) {
                  countryCode = phone.dialCode;
                },
                onChanged: (phone) {
                  number = phone.number;
                  print('+$countryCode$number');
                },
                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'Please enter a phone number.';
                  }
                  return null;
                },
              ),
              CustomDivider(
                height: height_60,
                isDivider: false,
              ),
              CustomButton(
                text: strContinue,
                color: AppColors.white,
                fontWeight: fontWeight800,
                font: font_16,
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    Get.toNamed('${AppRoutes.forgotPass2}?email=${emailController.text}&phone=+$countryCode$number');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
