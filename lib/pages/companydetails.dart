import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kodiary/colors.dart';
import 'package:kodiary/model/companymodel.dart';
import 'package:kodiary/pages/addprojectpage.dart';
import 'package:kodiary/provider/kodiary-provider.dart';
import 'package:kodiary/services/api.dart';
import 'package:provider/provider.dart';

class CompayDetails extends StatefulWidget {
  const CompayDetails({Key? key}) : super(key: key);

  @override
  State<CompayDetails> createState() => _CompayDetailsState();
}

class _CompayDetailsState extends State<CompayDetails> {
  final StreamController<CompanyModel> _streamController = StreamController();
  Stream<CompanyModel>? stream;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stream = _streamController.stream;
    getCompany();
  }

  getCompany() async {
    await Api.getProject();
    await Provider.of<CompanyProvider>(context, listen: false).fetchCompany();
    var companyModel =
        Provider.of<CompanyProvider>(context, listen: false).companyDetails;
    _streamController.add(companyModel!);
  }

  @override
  Widget build(BuildContext context) {
    String c = Api.appBarcolor;
    return Consumer<CompanyProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Company Details"),
            backgroundColor: HexColor(c.toString()),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider(
                          create: (context) {
                            return CompanyProvider();
                          },
                          child: const AddProject(),
                        );
                      },
                    ));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: Column(
            children: [
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
                  controller: nameController,
                  onChanged: (value) {
                    //Do something wi
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
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
                  controller: statusController,
                  onChanged: (value) {
                    //Do something wi
                  },
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Status',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
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
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                right: 75, left: 75, top: 15, bottom: 15)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    onPressed: () async {
                      await Api.addProject(
                          nameController.text, statusController.text);
                    },
                    child: const Text(
                      "Add Project",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
              Expanded(
                  child: StreamBuilder<CompanyModel>(
                      stream: stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CompanyModel c = snapshot.data!;
                          log("HHASS");
                          return ListView.builder(
                            itemCount: c.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(c.data![index].code.toString()),
                                subtitle:
                                    Text(c.data![index].category.toString()),
                              );
                            },
                          );
                        }
                        return Container();
                      }))
            ],
          ),
        );
      },
    );
  }
}
