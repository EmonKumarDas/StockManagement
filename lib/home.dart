import 'package:erp_software/SearchLostBydate.dart';
import 'package:erp_software/category.dart';
import 'package:erp_software/company.dart';
import 'package:erp_software/itemsetup.dart';
import 'package:erp_software/searchAndView.dart';
import 'package:erp_software/search_Damage_by_date.dart';
import 'package:erp_software/search_by_date.dart';
import 'package:erp_software/stockOut.dart';
import 'package:erp_software/stockin.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Widget Categories(name) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 4),
        width: 250,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(123, 41, 55, 117),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Category()),
                  );
                },
                child: Categories("Category Setup")),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Company()),
                  );
                },
                child: Categories("Company Setup")),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemSetup()),
                  );
                },
                child: Categories("Items Setup")),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StockIn()),
                  );
                },
                child: Categories("Stock In")),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StockOut()),
                  );
                },
                child: Categories("Stock Out")),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchAndView()),
                  );
                },
                child: Categories("Search & View Items Summary")),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchByDate()),
                );
              },
              child: Categories("View Sales Between Two Dates"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchDamageByDate()),
                );
              },
              child: Categories("View Damage Between Two Dates"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchLostByData()),
                );
              },
              child: Categories("View Lost Between Two Dates"),
            ),
          ],
        ));
  }
}
