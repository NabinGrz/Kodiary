import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kodiary/model/companymodel.dart';
import 'package:kodiary/model/projectmodel.dart';
import 'package:kodiary/services/api.dart';

class CompanyProvider extends ChangeNotifier {
  bool isLogging = false;
  CompanyProvider() {
    fetchCompany();
  }

  CompanyModel? companyDetails;
  fetchCompany() async {
    var comp = await Api.getCompany();
    companyDetails = comp;
    return companyDetails;
    log("Name${companyDetails!.data![0].name}");
    notifyListeners();
  }

  ProjectModel? projectDetails;
  fetchProject() async {
    var comp = await Api.getProject();
    companyDetails = comp;
    return companyDetails;
    log("Name${companyDetails!.data![0].name}");
    notifyListeners();
  }

  void addproject(String name, String status) async {
    await Api.addProject(name, status);
    notifyListeners();
  }
}
