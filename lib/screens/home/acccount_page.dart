import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/auth.dart';
import 'package:gym_app/screens/sign_in_page.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _Accountpage();
}

class _Accountpage extends State<AccountPage> {
  Future<void> _logout(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInPage()),
        (route) => false,
      );
    } catch (e) {
      if (kDebugMode) {
        print("error signing out");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: Icon(Iconsax.logout),
          ),
        ],
      ),
      body: buildAccountPage(),
    );
  }
}

Widget buildAccountPage() {
  return Container();
}
