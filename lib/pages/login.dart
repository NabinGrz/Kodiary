import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiary/colors.dart';
import 'package:kodiary/pages/companydetails.dart';
import 'package:kodiary/provider/kodiary-provider.dart';
import 'package:kodiary/services/api.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final String origin;
  const LoginPage({Key? key, required this.origin}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Email",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white.withOpacity(.9)),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              controller: emailController,
              onChanged: (value) {
                //Do something wi
              },
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: accentColor,
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              controller: passwordController,
              onChanged: (value) {
                //Do something wi
              },
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: accentColor,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [primaryColor, secondaryColor])),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      alignment: Alignment.center,
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          right: 75, left: 75, top: 15, bottom: 15)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                  onPressed: () async {
                    setState(() {
                      isLogin = true;
                    });
                    String email =
                        emailController.text.trim(); //""suman@kodiary.com
                    String password =
                        passwordController.text.trim(); //"P@ssw0rd
                    //widget.origin
                    isLogin = await Api.login(email, password);
                    setState(() {});
                    if (isLogin) {
                      setState(() {
                        isLogin = false;
                      });
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) {
                              return CompanyProvider();
                            },
                            child: const CompayDetails(),
                          );
                        },
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Invalid Password/Email")));
                    }
                    // Api.login("", "");
                  },
                  child: !isLogin
                      ? const Text(
                          "Login",
                          style: TextStyle(color: accentColor, fontSize: 16),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.red,
                        )))
        ],
      ),
    );
  }
}
