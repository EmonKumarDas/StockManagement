import 'package:erp_software/update_company.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Company extends StatefulWidget {
  const Company({Key? key}) : super(key: key);

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  final _CompanyController = TextEditingController();
  late DatabaseReference dbref;
  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('Company');
  }

  List companyList = [];
// fetch data

  Query dbRef = FirebaseDatabase.instance.ref().child('Company');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Company');

  Widget datalist({required Map com, index}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(index.toString())),
            Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(com['Comname'])),
            Container(
              width: MediaQuery.of(context).size.width / 7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              UpdateCompany(CompanyKey: com['key'])));
                },
                child: const Text("Edit"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              width: MediaQuery.of(context).size.width / 5,
              child: ElevatedButton(
                onPressed: () {
                  reference.child(com['key']).remove();
                },
                child: const Text("Delete"),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Company")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _CompanyController,
                  decoration: const InputDecoration(
                    hintText: 'Company Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (companyList.isEmpty) {
                    Map<String, String> company = {
                      'Comname': _CompanyController.text,
                    };
                    dbref.push().set(company);
                    _CompanyController.text = '';
                    Get.snackbar("Success", "Data inserted");
                  } else if (companyList.contains(_CompanyController.text)) {
                    Get.snackbar("Categori already exist",
                        "Please choose another category");
                  } else {
                    Map<String, String> company = {
                      'Comname': _CompanyController.text,
                    };
                    dbref.push().set(company);
                    _CompanyController.text = '';
                  }
                },
                color: Colors.blue,
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),

// End of Form

              Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Serial No",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Company Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        child: FirebaseAnimatedList(
                          shrinkWrap: true,
                          query: dbRef,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            Map cate = snapshot.value as Map;
                            cate['key'] = snapshot.key;
                            companyList.add(cate['Comname']);
                            companyList.toSet().toList();
                            return datalist(com: cate, index: index + 1);
                          },
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
