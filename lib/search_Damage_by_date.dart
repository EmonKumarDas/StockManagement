import 'package:erp_software/DamageData.dart';
import 'package:erp_software/showData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchDamageByDate extends StatefulWidget {
  SearchDamageByDate({Key? key}) : super(key: key);
  @override
  State<SearchDamageByDate> createState() => _SearchDamageByDate();
}

class _SearchDamageByDate extends State<SearchDamageByDate> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInputs = TextEditingController();

  Widget datalist({required Map cate}) {
    return Column(
      children: [],
    );
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    dateInputs.text = ""; //set the initial value of text field
    super.initState();
  }

  Query SellQantity = FirebaseDatabase.instance.ref().child('Damage');
  DatabaseReference dbrefSells =
      FirebaseDatabase.instance.ref().child('Damage');
  String formatdate2 = "";
  String formatdate1 = "";
  List items = [];
  List dates = [];
  List routdates = [];
  List routitem = [];
  List stockout = [];
  List routstock = [];
  int Store1 = 0;
  int Store2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Damage Data Search by Date"),
        backgroundColor: Colors.blue, //background color of app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(7),
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                    child: TextField(
                  controller: dateInput,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "From Date" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      formatdate1 =
                          formattedDate; //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ))),
            Container(
                padding: const EdgeInsets.all(7),
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                    child: TextField(
                  controller: dateInputs,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "To Date" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      formatdate2 = formattedDate;
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInputs.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ))),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                List setdates = [];
                for (int i = 0; i <= dates.length - 1; i++) {
                  if (formatdate1 == dates[i]) {
                    setdates.add(dates[i]);
                    print(setdates.length);
                  }
                }

                for (int i = 0; i <= dates.length - 1; i++) {
                  if (dates[i] == formatdate1) {
                    Store1 = i;
                  }
                  if (dates[i] == formatdate2) {
                    Store2 = i;
                  }
                }
                double newitems = setdates.length / 3;
                int newduble = newitems.round();
                for (int i = Store1 - newduble + 1; i <= Store2; i++) {
                  routitem.add(items[i]);
                  routstock.add(stockout[i]);
                  routdates.add(dates[i]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DamageData(
                              item: routitem,
                              stockout: routstock,
                              date: routdates)));
                }
              },
              child:
                  const Text("Search", style: TextStyle(color: Colors.white)),
            ),
            Container(
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: dbrefSells,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map Sell = snapshot.value as Map;

                  Sell['key'] = snapshot.key;
                  items.add(Sell["item"]);
                  dates.add(Sell["Date"]);
                  stockout.add(Sell["StockOutquantity"]);
                  return datalist(cate: Sell);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
