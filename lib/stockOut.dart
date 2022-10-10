import 'package:erp_software/showStockOutData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StockOut extends StatefulWidget {
  StockOut({Key? key}) : super(key: key);
  @override
  State<StockOut> createState() => _StockOutState();
}

class _StockOutState extends State<StockOut> {
  final _ItemController = TextEditingController();
  final _CompanyController = TextEditingController();
  final _RecodLevelcontroller = TextEditingController();
  final _AvailableController = TextEditingController();
  final _StockInController = TextEditingController();
  late DatabaseReference dbref;
  late DatabaseReference dbrefSell;
  late DatabaseReference dbrefDamage;
  late DatabaseReference dbrefLost;
  int selsCount = 0;
  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('StockOut');
    dbrefSell = FirebaseDatabase.instance.ref().child('Sell');
    dbrefDamage = FirebaseDatabase.instance.ref().child('Damage');
    dbrefLost = FirebaseDatabase.instance.ref().child('Lost');
  }

  Query dbRefItem = FirebaseDatabase.instance.ref().child('ItemSetup');
  Query dbRefcom = FirebaseDatabase.instance.ref().child('Company');
  Query stockquantity = FirebaseDatabase.instance.ref().child('StockIn');
  Query SellQantity = FirebaseDatabase.instance.ref().child('Sell');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('StockIn');
  DatabaseReference dbrefSells = FirebaseDatabase.instance.ref().child('Sell');

  List<String> listItem = [];
  final listcom = [];
  List<String> Record = [];
  List<String> stoutavailable = [];
  int itemvalue = 0;
  int comvalue = 0;
  List<String> availableQantity = [];
  String newquant = '0';
  List newItem = [];
  List newcomany = [];
  List date = [];
  List item = [];
  int index = 0;
  List alldata = [];
  List serial = [];
  List items = [];
  List company = [];
  int newindexpro = 0;
// fetch data
  Query dbRef = FirebaseDatabase.instance.ref().child('StockIn');
  DatabaseReference references =
      FirebaseDatabase.instance.ref().child('StockIn');
  Widget datalist({required Map cate, index}) {
    return Column(
      children: [],
    );
  }

  Widget form() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stock Out"),
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
                        Expanded(child: TextField(controller: _ItemController)),
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
                        Text("Company :"),
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
                                _AvailableController.text =
                                    stoutavailable[itemvalue];
                              }
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
                        hintText: 'Stock out quantity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      Map<String, String> categories = {
                        'item': _ItemController.text,
                        'Company': _CompanyController.text,
                        'recordLevel': _RecodLevelcontroller.text,
                        'availableQantity': _AvailableController.text,
                        'StockOutquantity': _StockInController.text,
                      };
                      if (_ItemController.text != '' &&
                          _CompanyController.text != '' &&
                          _RecodLevelcontroller.text != '' &&
                          _AvailableController.text != '' &&
                          _StockInController.text != '') {
                        dbref.push().set(categories);
                      } else {
                        const AlertDialog(
                          title: Text("Please fill up the form"),
                        );
                      }
                      final itemvalues = itemvalue + 1;
                      int available = int.parse(_AvailableController.text);
                      int stock = int.parse(_StockInController.text);
                      int sumtotal = available - stock;
                      if (sumtotal <= 5) {
                        Get.snackbar(
                            "Oh No", "Available quantity is under $sumtotal");
                      }
                      reference.child("stock$itemvalues").update({
                        'availableQantity': sumtotal.toString(),
                        'StockInquantity': _StockInController.text,
                      });
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ShowStockOutData(
                                  sl: serial,
                                  item: items,
                                  company: company,
                                  availablequantity: stoutavailable)));
                    },
                    color: Colors.blue,
                    child: const Text(
                      "See Data",
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
                        listItem.toSet().toList();
                        Record.add(cat['record'].toString());
                        Record.toSet().toList();

                        Record.toSet().toList();
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
                        listcom.toSet().toList();
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

                        availableQantity
                            .add(stock['StockInquantity'].toString());
                        availableQantity.toSet().toList();
                        return form();
                      },
                    ),
                  ),
                  // Container(
                  //   child: FirebaseAnimatedList(
                  //     shrinkWrap: true,
                  //     query: stockquantity,
                  //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  //         Animation<double> animation, int index) {
                  //       Map stock = snapshot.value as Map;
                  //       stock['key'] = snapshot.key;
                  //       stock['availableQantity'] = availableQantity;

                  //       return form();
                  //     },
                  //   ),
                  // ),
                  Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
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
                                serial.add(cate['recordLevel']);
                                items.add(cate['item']);
                                company.add(cate['Company']);
                                stoutavailable.add(cate['availableQantity']);
                                return datalist(cate: cate, index: index + 1);
                              },
                            ),
                          ),
                        ],
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: ElevatedButton(
                          onPressed: () {
                            selsCount++;
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            String formattedDate = formatter.format(now);
                            dbrefSells.push().set({
                              'item': _ItemController.text,
                              'Company': _CompanyController.text,
                              'StockOutquantity': _StockInController.text,
                              'Date': formattedDate,
                              'sCount': selsCount,
                            }).then((value) => {Navigator.pop(context)});
                          },
                          child: const Text("Sell"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ElevatedButton(
                          onPressed: () {
                            selsCount++;
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            String formattedDate = formatter.format(now);
                            dbrefDamage.push().set({
                              'item': _ItemController.text,
                              'Company': _CompanyController.text,
                              'StockOutquantity': _StockInController.text,
                              'Date': formattedDate,
                              'sCount': selsCount,
                            }).then((value) => {Navigator.pop(context)});
                          },
                          child: const Text("Damage"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: ElevatedButton(
                          onPressed: () {
                            selsCount++;
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            String formattedDate = formatter.format(now);
                            dbrefLost.push().set({
                              'item': _ItemController.text,
                              'Company': _CompanyController.text,
                              'StockOutquantity': _StockInController.text,
                              'Date': formattedDate,
                              'sCount': selsCount,
                            }).then((value) => {Navigator.pop(context)});
                          },
                          child: const Text("Lost"),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   child: FirebaseAnimatedList(
                  //     shrinkWrap: true,
                  //     query: SellQantity,
                  //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  //         Animation<double> animation, int index) {
                  //       Map Sell = snapshot.value as Map;
                  //       Sell['key'] = snapshot.key;
                  //       date.add(Sell['Date']);
                  //       date.toSet().toList();
                  //       item.add(Sell['item']);
                  //       item.toSet().toList();
                  //       return form();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
