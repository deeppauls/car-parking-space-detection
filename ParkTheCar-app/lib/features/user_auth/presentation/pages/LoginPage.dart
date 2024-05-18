import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_pageapp/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/HomePage.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:login_pageapp/features/user_auth/presentation/widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? errorMessage = "";
  // bool isLogin = true;
  // final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Auth()
          .signIn(
              email: _emailController.text, password: _passwordController.text)
          .whenComplete(
            () => Navigator.pushReplacementNamed(context, HomePage.routeName),
          );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    // bool isLoading = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ParkTheCar",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: signIn,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator())
                          : Text(
                              "LogIn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account?"),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, HomePage.routeName);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        (route) => false);
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // void _signIn() async {
  //   String email = _emailController.text;
  //   String password = _passwordController.text;

  //   print(password);
  //   print(email);

  //   User? user = await _auth.signInWithEmailAndPassword(email, password);
  //   //     .whenComplete(
  //   //           () => Navigator.pushNamed(context, HomePage.routeName)
  //   //         );
  //   // if (user == null) {
  //   //   print("some error occured");
  //   //   Navigator.pop(context);
  //   //}

  //   if (user != null) {
  //     print("User is successfully created");
  //     Navigator.pushReplacementNamed(context, HomePage.routeName);
  //   } else {
  //     print("Some error happend");
  //   }
  // }
}
