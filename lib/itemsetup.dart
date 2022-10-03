import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemSetup extends StatefulWidget {
  ItemSetup({Key? key}) : super(key: key);

  @override
  State<ItemSetup> createState() => _ItemSetupState();
}

class _ItemSetupState extends State<ItemSetup> {
  final _Categorcontroller = TextEditingController();
  final _CompanyController = TextEditingController();
  final _ItemController = TextEditingController();
  final _RecordController = TextEditingController();
  late DatabaseReference dbref;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('ItemSetup');
  }

  Query dbRefcate = FirebaseDatabase.instance.ref().child('Category');
  Query dbRefcom = FirebaseDatabase.instance.ref().child('Company');
  Query dbItemSetup = FirebaseDatabase.instance.ref().child('ItemSetup');
  final listcat = [];
  final listcom = [];
  final itemSetupReorder = [];
  int count = 0;
  Widget form() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ItemSetup"),
        ),
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(controller: _Categorcontroller)),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String values) {
                            _Categorcontroller.text = values;
                          },
                          itemBuilder: (BuildContext context) {
                            return listcat.map<PopupMenuItem<String>>((values) {
                              return PopupMenuItem(
                                  child: Text(values), value: values);
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          controller: _CompanyController,
                        )),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _CompanyController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return listcom.map<PopupMenuItem<String>>((value) {
                              return PopupMenuItem(
                                  child: Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _ItemController,
                      decoration: const InputDecoration(
                        hintText: 'Item Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      int values = itemSetupReorder.length + 1;
                      Map<String, String> categories = {
                        'Categories': _Categorcontroller.text,
                        'Company': _CompanyController.text,
                        'item': _ItemController.text,
                        'record': values.toString(),
                      };
                      if (_Categorcontroller.text != '' &&
                          _CompanyController.text != '' &&
                          _ItemController.text != '') {
                        dbref
                            .push()
                            .set(categories)
                            .then((value) => {Navigator.pop(context)});
                      } else {
                        Get.snackbar("Warning", "Please fill up the form");
                      }
                      _Categorcontroller.text = '';
                      _CompanyController.text = '';
                      _ItemController.text = '';
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // fatch data from database
                  Container(
                    child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: dbRefcate,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map cat = snapshot.value as Map;
                        cat['key'] = snapshot.key;
                        listcat.add(cat['Catname'].toString());
                        return form();
                      },
                    ),
                  ),

                  Container(
                    child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: dbRefcom,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map com = snapshot.value as Map;
                        com['key'] = snapshot.key;
                        listcom.add(com['Comname'].toString());
                        return form();
                      },
                    ),
                  ),
                  Container(
                    child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: dbItemSetup,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map com = snapshot.value as Map;
                        com['key'] = snapshot.key;
                        itemSetupReorder.add(com['record'].toString());
                        return form();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
