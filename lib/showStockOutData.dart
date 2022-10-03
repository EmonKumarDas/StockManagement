import 'package:erp_software/home.dart';
import 'package:flutter/material.dart';

class ShowStockOutData extends StatefulWidget {
  ShowStockOutData(
      {Key? key,
      required this.sl,
      required this.item,
      required this.company,
      required this.availablequantity})
      : super(key: key);

  final List sl;
  final List item;
  final List company;
  final List availablequantity;
  @override
  State<ShowStockOutData> createState() => _ShowStockOutDataState();
}

TableRow tables(sl, item, company, available, index) {
  return TableRow(children: [
    Column(children: [Text(sl[index])]),
    Column(children: [
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          item[index],
          textAlign: TextAlign.center,
        ),
      )
    ]),
    Column(children: [Text(company[index])]),
    Column(children: [Text(available[index])]),
  ]);
}

class _ShowStockOutDataState extends State<ShowStockOutData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Stock out Data'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(70.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Column(children: const [
                      Text('Sl', style: TextStyle(fontSize: 15.0))
                    ]),
                    Column(children: const [
                      Text('Item', style: TextStyle(fontSize: 15.0))
                    ]),
                    Column(children: const [
                      Text('Company', style: TextStyle(fontSize: 15.0))
                    ]),
                    Column(children: const [
                      Text('AvailableQuantity',
                          style: TextStyle(fontSize: 15.0))
                    ]),
                  ]),
                  for (int i = 0; i <= widget.item.length - 1; i++)
                    tables(widget.sl, widget.item, widget.company,
                        widget.availablequantity, i)
                ],
              ),
            ),
            // Text("Total:${countpush[2]}"),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              child: Text('Back'),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
            ),
          ]))),
    );
  }
}
