import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateCompany extends StatefulWidget {
  const UpdateCompany({Key? key, required this.CompanyKey}) : super(key: key);
  final String CompanyKey;
  @override
  State<UpdateCompany> createState() => _UpdateCompanyState();
}

class _UpdateCompanyState extends State<UpdateCompany> {
  final _CompanyController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Company');
    getCategoryData();
  }

  void getCategoryData() async {
    DataSnapshot snapshot = await dbRef.child(widget.CompanyKey).get();
    Map category = snapshot.value as Map;
    _CompanyController.text = category['Comname'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Updating data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _CompanyController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                  hintText: 'Enter Category',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> company = {
                    'Comname': _CompanyController.text,
                  };
                  dbRef
                      .child(widget.CompanyKey)
                      .update(company)
                      .then((value) => {Navigator.pop(context)});
                },
                child: const Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
