import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kodiary/model/companymodel.dart';
import 'package:kodiary/model/projectmodel.dart';

String url =
    "https://gateway.cronlink.ca/api/v1/authentication/companies-listing";
String domain = 'suman.cronlink.ca';
String l = "gateway.cronlink.ca";

class Api {
  static String appBarcolor = "";
  static String token = "";

  ///
  static Future getCompany() async {
    //https://gateway.cronlink.ca/api/v1/authentication/companies-listing
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var companyModel = CompanyModel.fromJson(data);
      //  log(d.toString());
      log(companyModel.data![0].name.toString());
      return companyModel;
    } else {
      log("ERROR");
    }
  }

  static Future getProject() async {
    String tk = Api.token;
    //https://gateway.cronlink.ca/api/v1/project/projects
    var response = await http.get(
        Uri.parse("https://gateway.cronlink.ca/api/v1/project/projects"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tk',
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var projectModel = ProjectModel.fromJson(data);
      //  log(d.toString());
      log(projectModel.data![0].name.toString());
      return projectModel;
    } else {
      log("ERROR");
    }
  }

  static Future<bool> login(String email, String password) async {
    var responseLogin =
        await http.post(Uri.https(l, 'api/v1/authentication/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              <String, dynamic>{
                "email": email,
                "password": password,
              },
            ));

    if (responseLogin.statusCode == 200) {
      var domainData = jsonDecode(responseLogin.body);
      token = domainData["token"];
      appBarcolor = domainData["theme"]["palettes"][0]["value"];
      log(domainData["theme"]["palettes"][0]["value"]);
      return true;
    } else {
      log("ERROR");
      return false;
    }
  }

  static addProject(String name, String status) async {
    var response = await http.post(
        Uri.https("gateway.cronlink.ca", 'api/v1/project/projects'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "name": name,
            "status": status,
          },
        ));

    if (response.statusCode == 200) {
      log("ADDED");
    } else {
      log("ERROR");
    }
  }
}
