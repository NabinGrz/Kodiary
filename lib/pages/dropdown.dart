import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kodiary/model/companymodel.dart';
import 'package:kodiary/pages/login.dart';
import 'package:kodiary/provider/kodiary-provider.dart';
import 'package:provider/provider.dart';

class DropDownClass extends StatefulWidget {
  const DropDownClass({
    Key? key,
  }) : super(key: key);

  @override
  State<DropDownClass> createState() => _DropDownClassState();
}

class _DropDownClassState extends State<DropDownClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CompanyProvider>(
            builder: (context, companyProvider, child) {
              return TypeAheadField(
                getImmediateSuggestions: true,
                textFieldConfiguration: TextFieldConfiguration(
                  enabled: true,
                  style: DefaultTextStyle.of(context).style,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "",
                    hintStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 194, 193, 193),
                          width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 194, 193, 193),
                          width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    color: Color.fromARGB(255, 226, 226, 226),
                    //elevation: 100.0

                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                debounceDuration: const Duration(milliseconds: 400),
                suggestionsCallback: (val) async {
                  //      log(companyModel.data![0].name.toString());
                  var dd = companyProvider.companyDetails;
                  return dd!.data!.where(
                      (element) => element.name!.contains(val.toLowerCase()));
                  //return marketProv.market
                  //   .where((element) => element.id!.contains(val.toLowerCase()));
                },
                itemBuilder: (context, Datum data) {
                  //  return Container();
                  return ListTile(
                    title: Text(data.name.toString()),
                  );
                },
                onSuggestionSelected: (Datum data) async {
                  Navigator.push(context, CupertinoPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) {
                          return CompanyProvider();
                        },
                        child: LoginPage(origin: data.domain.toString()),
                      );
                    },
                  ));
                },
                //onSuggestionSelected: (CryptoCurrencyModel currencyModel) async {
                //   var data = await marketProv.fetchMarketChart(currencyModel.id!);
                //   Navigator.push(context, MaterialPageRoute(
                //     builder: (context) {
                //       return DetailPage(id: currencyModel.id!, priceData: data);
                //     },
                //   ));
                // },
              );
            },
          )
        ],
      ),
    );
  }
}
