import 'package:erp_software/home.dart';
import 'package:flutter/material.dart';

class Datashow extends StatefulWidget {
  const Datashow(
      {super.key,
      required this.item,
      required this.stockout,
      required this.date});
  final List item;
  final List stockout;
  final List date;
  @override
  State<Datashow> createState() => _DatashowState();
}

TableRow tables(item, stockout, date, index) {
  return TableRow(children: [
    Column(children: [Text(item[index])]),
    Column(children: [Text(stockout[index])]),
    Column(children: [Text(date[index])]),
  ]);
}


class _DatashowState extends State<Datashow> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Data Show BY Date'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(120.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Column(children: const [
                      Text('Item', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: const [
                      Text('Sell', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: const [
                      Text('Date', style: TextStyle(fontSize: 20.0))
                    ]),
                  ]),
                  for (int i = 0; i <= widget.stockout.length - 1; i++)
                    tables(widget.item, widget.stockout, widget.date, i)
                ],
              ),
            ),
            // Text("Total:${countpush[2]}"),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: const Text('Back'),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
            ),
          ]))),
    );
  }
}
