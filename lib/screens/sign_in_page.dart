import 'package:flutter/material.dart';
import 'package:gym_app/widgets/login_card.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gym Bros")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sign in", style: TextStyle(fontSize: 50)),
              SizedBox(height: 40),
              ToggleLoginCard(),
            ],
          ),
        ),
      ),
    );
  }
}
