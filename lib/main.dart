import 'package:flutter/material.dart';
import 'package:shopping_assist/pages/first_view.dart';
import 'package:shopping_assist/pages/home_page.dart';
import 'package:shopping_assist/widgets/provider_widget.dart';
import 'services/authentication.dart';
import 'package:shopping_assist/pages/sign_up_view.dart';

void main() => runApp(ShoppingAssist());

class ShoppingAssist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shopping Assist",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
        },
      )
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn? HomePage(auth: auth,): FirstView();
        }
        return CircularProgressIndicator();
      }
    );
    
  }
}