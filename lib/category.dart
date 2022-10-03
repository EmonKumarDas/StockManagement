import 'package:erp_software/update_category.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _CategoriController = TextEditingController();
  late DatabaseReference dbref;
  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('Category');
  }

  List categoriesList = [];
// fetch data
  Query dbRef = FirebaseDatabase.instance.ref().child('Category');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Category');
  Widget datalist({required Map cate, index}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(index.toString())),
            Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(cate['Catname'])),
            Container(
              width: MediaQuery.of(context).size.width / 7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              UpdateCategory(categoreyKey: cate['key'])));
                },
                child: const Text("Edit"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              width: MediaQuery.of(context).size.width / 5,
              child: ElevatedButton(
                onPressed: () {
                  reference.child(cate['key']).remove();
                },
                child: const Text("Delete"),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(categoriesList);
    return Scaffold(
        appBar: AppBar(title: Text("Category")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _CategoriController,
                  decoration: const InputDecoration(
                    hintText: 'Category Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (categoriesList.isEmpty) {
                    Map<String, String> categories = {
                      'Catname': _CategoriController.text,
                    };
                    dbref.push().set(categories);

                    _CategoriController.text = '';
                  } else if (categoriesList
                      .contains(_CategoriController.text)) {
                    Get.snackbar("Categori already exist",
                        "Please choose another category");
                  } else {
                    Map<String, String> categories = {
                      'Catname': _CategoriController.text,
                    };
                    dbref.push().set(categories);

                    _CategoriController.text = '';
                  }
                },
                color: Colors.blue,
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // End of Form

              Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Serial No",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Category Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                            categoriesList.add(cate['Catname']);
                            categoriesList.toSet().toList();
                            return datalist(cate: cate, index: index + 1);
                          },
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
