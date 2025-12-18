import 'package:flutter/material.dart';
import 'package:gym_app/auth/auth.dart';
import 'package:gym_app/screens/sign_in_page.dart';
import 'package:gym_app/second%20try/pages/homePage.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<CustomUser?>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          CustomUser? user = snapshot.data;
          if (user == null) {
            return SignInPage();
          } else {
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: HomePageNew(),
            );
          }
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

abstract class Database {}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid.isNotEmpty);
  final String uid;
}
