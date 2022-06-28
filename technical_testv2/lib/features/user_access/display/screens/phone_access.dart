import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import 'package:technical_testv2/utils/utils.dart';

class PhoneAccess extends StatefulWidget {
  const PhoneAccess({Key? key}) : super(key: key);

  @override
  State<PhoneAccess> createState() => _PhoneAccessState();
}

class _PhoneAccessState extends State<PhoneAccess> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserAccessProvider userAccessProvider =
        Provider.of<UserAccessProvider>(context);

    bool clickChecker = false;

    final topPart = SizedBox(
      width: VariatedUtils.width(context) * 0.8,
      height: VariatedUtils.height(context) * 0.1,
      child: Column(
        children: [
          Text(
            "Phone access",
            style: VariatedUtils.textStyleUtil(20, Colors.black),
          ),
          Text("Hello, Welcome back again",
              style: VariatedUtils.textStyleUtil(15, Colors.grey)),
        ],
      ),
    );

    final phoneBox = TextField(
        textAlign: TextAlign.center,
        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: VariatedUtils.inputDecorationUtil("Phone number"));

    // ignore: sized_box_for_whitespace
    final iconDecoration = Center(
        child: SizedBox(
            height: VariatedUtils.height(context) * 0.25,
            child: Image.asset('assets/images/knock.png')));

    final textPhoneNumber = Container(
      padding: EdgeInsets.only(
          bottom: VariatedUtils.height(context) * 0.02,
          top: VariatedUtils.height(context) * 0.04),
      child: Text("Phone Number",
          style: VariatedUtils.textStyleUtil(17, Colors.black)),
    );

    final optButton = Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xffa1cfc2),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: VariatedUtils.width(context),
        onPressed: () {
          if (VariatedUtils.integerLengthVerification(
              phoneNumberController.text, 10)) {
            userAccessProvider.verifyPhoneNumberProviderFunction(
                phoneNumber: phoneNumberController.text,
                userAccessProvider: userAccessProvider,
                context: context);
          }
          clickChecker = true;
        },
        child: clickChecker
            ? const CircularProgressIndicator()
            : const Text(
                "Continuar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0XFF033236),
                    fontFamily: 'AmazingSlabBold'),
              ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(VariatedUtils.width(context) * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  topPart,
                  iconDecoration,
                  textPhoneNumber,
                  phoneBox,
                  VariatedUtils.personalizedSizedBox(
                      VariatedUtils.width(context) * 0.08),
                  optButton
                ],
              ),
            ),
          ),
        ));
  }
}
