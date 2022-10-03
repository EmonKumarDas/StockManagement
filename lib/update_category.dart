import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
 
class UpdateCategory extends StatefulWidget {
  
  const UpdateCategory({Key? key, required this.categoreyKey}) : super(key: key);
 
  final String categoreyKey;
 
  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}
 
class _UpdateCategoryState extends State<UpdateCategory> {
final _CategoriController = TextEditingController();
  late DatabaseReference dbRef;
 
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Category');
    getCategoryData();
  }

  void getCategoryData() async {
    DataSnapshot snapshot = await dbRef.child(widget.categoreyKey).get();
    Map category = snapshot.value as Map;
    _CategoriController.text = category['Catname'];
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Updating data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _CategoriController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                  hintText: 'Enter Category',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
 
                  Map<String, String> category = {
                    'Catname': _CategoriController.text,
                  };
                  dbRef.child(widget.categoreyKey).update(category)
                  .then((value) => {
                     Navigator.pop(context) 
                  });
 
                },
                child: const Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}