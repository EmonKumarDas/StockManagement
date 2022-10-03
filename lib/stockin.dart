import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:erp_software/itemsetup.dart';

class StockIn extends StatefulWidget {
  StockIn({Key? key}) : super(key: key);
  @override
  State<StockIn> createState() => _StockInState();
}

class _StockInState extends State<StockIn> {
  final _ItemController = TextEditingController();
  final _CompanyController = TextEditingController();
  final _RecodLevelcontroller = TextEditingController();
  final _AvailableController = TextEditingController();
  final _StockInController = TextEditingController();
  int index = 0;
  late DatabaseReference dbref;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('StockIn');
  }

  Query dbRefItem = FirebaseDatabase.instance.ref().child('ItemSetup');
  Query dbRefcom = FirebaseDatabase.instance.ref().child('Company');
  Query stockquantity = FirebaseDatabase.instance.ref().child('StockIn');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('StockIn');

  List<String> listItem = [];
  final listcom = [];
  List<String> Record = [];
  int itemvalue = 0;
  int comvalue = 0;
  List<String> availableQantity = [];
  List<String> StockInqantity = [];
  List<String> currentavailableQantity = [];
  String newquant = '0';
  List newItem = [];
  List newcomany = [];
  int newindexpro = 0;
  List alldata = [];
  Widget form() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stock In"),
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
                        const Text("Item :"),
                        Expanded(child: TextField(controller: _ItemController,
                        
                        )),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String values) {
                            _ItemController.text = values;
                            _CompanyController.text = "";
                            int indexani = listItem.indexOf(values);
                            itemvalue = indexani;
                          },
                          itemBuilder: (BuildContext context) {
                            return listItem
                                .toSet()
                                .toList()
                                .map<PopupMenuItem<String>>((values) {
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
                        const Text("Company :"),
                        Expanded(
                            child: TextField(
                          controller: _CompanyController,
                        )),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _CompanyController.text = value;
                            int indexcom = listcom.indexOf(value);
                            comvalue = indexcom;
                            String itemvalues = _ItemController.text;
                            String comvalues = _CompanyController.text;

                            for (int i = 0; i <= alldata.length - 1; i++) {
                              if (alldata[i]['Company'] == comvalues &&
                                  alldata[i]['item'] == itemvalues) {
                                _RecodLevelcontroller.text =
                                    alldata[i]['record'];
                              } 
                            }

                            if (newItem.length == 0) {
                              _AvailableController.text = '0';
                            } else if (itemvalue >= newItem.length) {
                              _AvailableController.text = '0';
                            } else {
                              _AvailableController.text =
                                  availableQantity[itemvalue];
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return listcom
                                .toSet()
                                .toList()
                                .map<PopupMenuItem<String>>((value) {
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
                        keyboardType: TextInputType.number,
                      controller: _RecodLevelcontroller,
                      decoration: const InputDecoration(
                        hintText: 'Record Level',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                        keyboardType: TextInputType.number,
                      controller: _AvailableController,
                      decoration: const InputDecoration(
                        hintText: 'Available quantity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                        keyboardType: TextInputType.number,
                      controller: _StockInController,
                      decoration: const InputDecoration(
                        hintText: 'Stock In quantity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      int available = int.parse(_AvailableController.text);
                      int stock = int.parse(_StockInController.text);
                      int sumtotal = available + stock;
                      Map<String, String> categories = {
                        'item': _ItemController.text,
                        'Company': _CompanyController.text,
                        'recordLevel': _RecodLevelcontroller.text,
                        'availableQantity': sumtotal.toString(),
                        'StockInquantity': _StockInController.text,
                      };
                      if (_ItemController.text != '' &&
                          _CompanyController.text != '' &&
                          _RecodLevelcontroller.text != '' &&
                          _AvailableController.text != '' &&
                          _StockInController.text != '') {
                        if (newItem.length == 0) {
                          index++;
                          newindexpro = index;
                          reference
                              .child("stock$newindexpro")
                              .set(categories)
                              .then((value) => {Navigator.pop(context)});
                        } else if (newItem.contains(_ItemController.text)) {
                          final itemvalues = itemvalue + 1;

                          int available = int.parse(_AvailableController.text);
                          int stock = int.parse(_StockInController.text);
                          int sumtotal = available + stock;

                          reference.child("stock$itemvalues").update({
                            'availableQantity': sumtotal.toString(),
                            'StockInquantity': _StockInController.text,
                          }).then((value) => {Navigator.pop(context)});
                        } else {
                          final newindex = newItem.length + 1;
                          reference
                              .child("stock$newindex")
                              .set(categories)
                              .then((value) => {Navigator.pop(context)});
                        }
                      } else {
                        const AlertDialog(
                          title: Text("Please fill up the form"),
                        );
                      }
                      _ItemController.text = '';
                      _CompanyController.text = '';
                      _RecodLevelcontroller.text = '';
                      _StockInController.text = '';
                      _AvailableController.text = '';
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
                      query: dbRefItem,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map cat = snapshot.value as Map;
                        cat['key'] = snapshot.key;
                        alldata.add(cat);
                        listItem.add(cat['item'].toString());
                        Record.add(cat['record'].toString());
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
                      query: stockquantity,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map stock = snapshot.value as Map;
                        stock['key'] = snapshot.key;

                        newItem.add(stock['item']);
                        newItem.toSet().toList();

                        newcomany.add(stock['Company']);
                        newItem.toSet().toList();

                        StockInqantity.add(stock['StockInquantity'].toString());
                        StockInqantity.toSet().toList();
                        return form();
                      },
                    ),
                  ),

                  Container(
                    child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: stockquantity,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map availableQan = snapshot.value as Map;
                        availableQan['key'] = snapshot.key;
                        availableQantity.add(availableQan['availableQantity']);
                        availableQantity.toSet().toList();
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
