// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_integration/signin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Media Integration"),
        backgroundColor: Color.fromARGB(255, 53, 1, 99),
      ),
      body: loginUI(),
    );
  }

  Widget loginUI() {
    return Consumer<LoginController>(
      builder: (context, model, child) {
        if (model.userDetails != null) {
          return Center(
            child: loggedInUI(model),
          );
        } else {
          return loginControls(context);
        }
      },
    );
  }

  Widget loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.userDetails!.photoUrl ?? '').image,
          radius: 60,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(model.userDetails!.displayName ?? ''),
        Text(model.userDetails!.email ?? ''),
        const SizedBox(
          height: 60,
        ),
        Text(
          "Can't show more credentials",
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
        ActionChip(
          avatar: const Icon(Icons.logout),
          elevation: 6,
          padding: EdgeInsets.all(8),
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          labelPadding: EdgeInsets.only(left: 5, top: 3, right: 8, bottom: 2),
          label: const Text("Logout"),
          onPressed: () {
            Provider.of<LoginController>(context, listen: false).logOut();
          },
        )
      ],
    );
  }

  Center loginControls(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('The Sparks Foundation',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'NerkoOne')),
        Image.asset("images/logo.png"),
        Text('Mobile-App Development Intern\n\t\t\t\t          ~Krish Chopra',
            style: TextStyle(
                fontSize: 19,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 50,
        ),
        GestureDetector(
          child: Image.asset(
            "images/google.png",
            width: 280,
          ),
          onTap: () {
            Provider.of<LoginController>(context, listen: false).googleLogin();
          },
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          child: Image.asset(
            "images/fb.png",
            width: 280,
          ),
          onTap: () {
            Provider.of<LoginController>(context, listen: false)
                .facebookLogin();
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
