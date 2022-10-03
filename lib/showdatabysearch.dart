import 'package:erp_software/home.dart';
import 'package:flutter/material.dart';

class Showdatabysearch extends StatefulWidget {
  const Showdatabysearch({
    super.key,
    required this.reorders,
    required this.items,
    required this.company,
    required this.categories,
    required this.available,
  });
  final List reorders;
  final List items;
  final List company;
  final List categories;
  final List available;

  @override
  State<Showdatabysearch> createState() => _ShowdatabysearchState();
}

TableRow tables(reorders, items, company, categories, available, index) {
  return TableRow(children: [
    Column(children: [Text(reorders[index])]),
    Column(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(items[index]),
      )
    ]),
    Column(children: [Text(company[index])]),
    Column(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(categories[index]),
      )
    ]),
    Column(children: [Text(available[index].toString())]),
  ]);
}

class _ShowdatabysearchState extends State<Showdatabysearch> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Show Data'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(65.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
                children: [
                  TableRow(children: [
                    Column(children: const [
                      Text('Reorder', style: TextStyle(fontSize: 10.0))
                    ]),
                    Column(children: const [
                      Text('Items', style: TextStyle(fontSize: 10.0))
                    ]),
                    Column(children: const [
                      Text('Company', style: TextStyle(fontSize: 10.0))
                    ]),
                    Column(children: const [
                      Text('Category', style: TextStyle(fontSize: 10.0))
                    ]),
                    Column(children: const [
                      Text('Available', style: TextStyle(fontSize: 10.0))
                    ]),
                  ]),
                  for (int i = 0; i <= widget.items.length - 1; i++)
                    tables(widget.reorders, widget.items, widget.company,
                        widget.categories, widget.available, i),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
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
