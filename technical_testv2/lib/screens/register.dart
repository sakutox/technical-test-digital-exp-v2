import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/models/user_firebase.dart';

import '../providers/provider.dart';
import '../utils/utils.dart';

class Register extends StatelessWidget {
  final String phone;
  const Register({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

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
          'Register',
          style: VariatedUtils.textStyleUtil(20, Colors.black),
        ));

    final imageDecoration = Center(
        child: SizedBox(
            height: VariatedUtils.height(context) * 0.3,
            child: Image.asset('assets/images/resume.png')));

    final middlePartTexts = SizedBox(
      width: VariatedUtils.width(context) * 0.8,
      height: VariatedUtils.height(context) * 0.1,
      child: Column(
        children: [
          Text(
            "Create a new account",
            style: VariatedUtils.textStyleUtil(20, Colors.black),
          ),
          Text(
              "Welcome to the register page in this section you'll find the necesary data to create an account with us",
              textAlign: TextAlign.center,
              style: VariatedUtils.textStyleUtil(15, Colors.grey)),
        ],
      ),
    );

    TextField textFieldGenerator(
        TextEditingController controller, String textFieldLabel) {
      return TextField(
          textAlign: TextAlign.center,
          controller: controller,
          keyboardType: TextInputType.name,
          decoration: VariatedUtils.inputDecorationUtil(textFieldLabel));
    }

    final confirmRegistration = Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xffa1cfc2),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: VariatedUtils.width(context),
        onPressed: () {
          
          provider.userProvider.email = emailController.text;
          provider.userProvider.phone = phone;
          provider.userProvider.name = nameController.text;

          provider.userProvider.createUser(provider.userProvider, context);
        },
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color(0XFF033236),
              fontFamily: 'AmazingSlabBold'),
        ),
      ),
    );

    return Scaffold(
        appBar: appBar,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(VariatedUtils.width(context) * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageDecoration,
                VariatedUtils.personalizedSizedBox(30),
                middlePartTexts,
                VariatedUtils.personalizedSizedBox(30),
                textFieldGenerator(nameController, 'Name'),
                VariatedUtils.personalizedSizedBox(15),
                textFieldGenerator(emailController, 'Email'),
                VariatedUtils.personalizedSizedBox(30),
                confirmRegistration,
              ],
            ),
          ),
        )));
  }
}
