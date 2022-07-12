import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:kodiary/pages/companydetails.dart';
import 'package:kodiary/pages/login.dart';
import 'package:kodiary/provider/kodiary-provider.dart';
import 'package:kodiary/services/api.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

void main() {
  runApp(const MaterialApp(home: MyApp()));
  Api.getCompany();
  //hmac();
}

void hmac() {
  var key = utf8.encode('p@ss');
  var b =
      utf8.encode('{"password":"121212","phone":"9812345678","user":"admin")');

  var hmacSha256 = Hmac(sha256, key);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return CompanyProvider();
            },
          )
        ],
        child: const LoginPage(
          origin: "",
        ));
  }
}
