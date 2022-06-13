import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/utils/utils.dart';
import '../providers/provider.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  const OtpScreen({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    final appBar = AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          'OTP',
          style: VariatedUtils.textStyleUtil(20, Colors.black),
        ));

    final iconDecoration = Center(
        child: SizedBox(
            height: VariatedUtils.height(context) * 0.3,
            child: Image.asset('assets/images/signup.png')));

    final middlePartTexts = SizedBox(
      width: VariatedUtils.width(context) * 0.8,
      height: VariatedUtils.height(context) * 0.1,
      child: Column(
        children: [
          Text(
            "Verification Code",
            style: VariatedUtils.textStyleUtil(20, Colors.black),
          ),
          Text("We've sent you the verification code to your mobile number",
              textAlign: TextAlign.center,
              style: VariatedUtils.textStyleUtil(15, Colors.grey)),
        ],
      ),
    );

    final confirmOtpButton = Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xffa1cfc2),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: VariatedUtils.width(context),
        onPressed: () {
          provider.verifyPhoneNumberAgain(
              provider.verificationIdUser, provider.otpCode, context);
        },
        child: const Text(
          "Continue",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color(0XFF033236),
              fontFamily: 'AmazingSlabBold'),
        ),
      ),
    );

    final verificationCodeField = VerificationCode(
      onCompleted: (String value) {
        if (VariatedUtils.integerLengthVerification(value, 6)) {
          provider.otpCode = value;
        }
      },
      onEditing: (bool bool) {},
      length: 6,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(VariatedUtils.width(context) * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconDecoration,
                VariatedUtils.personalizedSizedBox(30),
                middlePartTexts,
                VariatedUtils.personalizedSizedBox(30),
                verificationCodeField,
                VariatedUtils.personalizedSizedBox(30),
                confirmOtpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
