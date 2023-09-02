import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String uid='';
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
 Future<void> regester() async {
   User? user = auth.currentUser;
  String uid = user!.uid;
  var time=DateTime.now();
  await firestore.collection('file').doc(uid).collection('mytask').doc(time.toString()).set({
    'Name':nameController.text,
    'Father':fatherController.text,
    'Age':ageController.text,
    'Qualification':qualificationController.text,
    'time':time.toString(),
    'Timestamp':time,

  });
  // here you write the codes to input the data into firestore
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create list",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter Your Information",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name',
                      hintText: 'Enter Your Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: fatherController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Father Name',
                      hintText: 'Parent Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Your Age',
                      hintText: ' Your Age'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: qualificationController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Qualification',
                      hintText: 'Enter Your Qualification'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  //   color: Colors.amber,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.black;
                      return Colors.amber;
                    })),
                    onPressed: regester,
                    child: const Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
