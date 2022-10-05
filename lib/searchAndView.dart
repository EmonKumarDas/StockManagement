import 'package:erp_software/showdatabysearch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SearchAndView extends StatefulWidget {
  SearchAndView({Key? key}) : super(key: key);
  @override
  State<SearchAndView> createState() => _SearchAndViewState();
}

class _SearchAndViewState extends State<SearchAndView> {
  final _ItemController = TextEditingController();
  final _CompanyController = TextEditingController();
  late DatabaseReference dbref;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('StockOut');
  }

  Query dbRefItem = FirebaseDatabase.instance.ref().child('ItemSetup');
  Query dbRefcom = FirebaseDatabase.instance.ref().child('Company');
  Query stockquantity = FirebaseDatabase.instance.ref().child('StockIn');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('StockIn');

  List<String> listItem = [];
  final listcom = [];
  List<String> item = [];
  List<String> Record = [];
  List<String> stoutavailable = [];
  int itemvalue = 0;
  int comvalue = 0;
  List<String> availableQantity = [];
  String newquant = '0';
  List alldata = [];
  List reorders = [];
  List company = [];
  List items = [];
  List allitemdata = [];
  List categories = [];
  List available = [];
// fetch data
  Query dbRef = FirebaseDatabase.instance.ref().child('StockIn');

  Widget form() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search And View"),
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
                        const Text("Category :"),
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
                  MaterialButton(
                    onPressed: () {
                      
                      if (_CompanyController.text != "" &&
                          _ItemController.text != "") {
                        for (int i = 0; i <= allitemdata.length - 1; i++) {
                          if (allitemdata[i]['Company'] ==
                                  _CompanyController.text &&
                              allitemdata[i]['Categories'] ==
                                  _ItemController.text) {
                            reorders.add(allitemdata[i]['record']);
                            company.add(allitemdata[i]['Company']);
                            items.add(allitemdata[i]['item']);
                            categories.add(allitemdata[i]['Categories']);
                            available.add(alldata[i]['availableQantity']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Showdatabysearch(
                                          reorders: reorders,
                                          items: items,
                                          categories: categories,
                                          company: company,
                                          available: available,
                                        )));
                          }
                        }
                      } else if (_CompanyController.text != "" &&
                              _ItemController.text == "" ||
                          _ItemController.text != "" &&
                              _CompanyController.text == "") {
                        for (int i = 0; i <= allitemdata.length - 1; i++) {
                          if (allitemdata[i]['Company'] ==
                                  _CompanyController.text ||
                              allitemdata[i]['Categories'] ==
                                  _ItemController.text) {
                            reorders.add(allitemdata[i]['record']);
                            company.add(allitemdata[i]['Company']);
                            items.add(allitemdata[i]['item']);
                            categories.add(allitemdata[i]['Categories']);

                            available.add(alldata[i]['availableQantity']);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Showdatabysearch(
                                          reorders: reorders,
                                          items: items,
                                          categories: categories,
                                          company: company,
                                          available: available,
                                        )));
                          }
                        }
                      }
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Search',
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
                        allitemdata.add(cat);
                        item.add(cat['item'].toString());
                        listItem.add(cat['Categories'].toString());
                        listItem.toSet().toList();
                        Record.add(cat['record'].toString());
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

                        stock['availableQantity'] = availableQantity;
                        return form();
                      },
                    ),
                  ),
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
                                alldata.add(cate);
                                stoutavailable.add(cate['availableQantity']);
                                return form();
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
