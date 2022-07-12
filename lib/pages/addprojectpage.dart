import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:kodiary/colors.dart';
import 'package:kodiary/provider/kodiary-provider.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, snapshot) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [],
          ),
        ),
      );
    });
  }
}
