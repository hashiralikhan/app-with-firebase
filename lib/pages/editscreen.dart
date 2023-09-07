import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditScreen extends StatefulWidget {
  final String uid;
  final String documentId;

  EditScreen({required this.uid, required this.documentId});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the existing data for the document and populate the text controllers
    fetchDocumentData();
  }

  fetchDocumentData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('file')
        .doc(widget.uid)
        .collection('mytask')
        .doc(widget.documentId)
        .get();

    if (snapshot.exists) {
       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>; // Explicit casting

    setState(() {
      nameController.text = data['Name'];
      fatherController.text = data['Father'];
      ageController.text = data['Age'];
      qualificationController.text = data['Qualification'];
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Edit Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      onPressed: updateData,
                      child: const Text("Save change"),
                    ),
                  )
                ],
              ),
            ),
      ),
    );
  }

  updateData() async {
    try {
      await FirebaseFirestore.instance
          .collection('file')
          .doc(widget.uid)
          .collection('mytask')
          .doc(widget.documentId)
          .update({
        'Name': nameController.text,
        'Father': fatherController.text,
        'Age': ageController.text,
        'Qualification': qualificationController.text,
      });
     Fluttertoast.showToast(msg: 'Data updated successfully');
      // Data updated successfully
      Navigator.pop(context); // Return to the previous screen
    } catch (e) {
      // Handle any errors that occur during the update
      print('Error updating document: $e');
    }
  }
}
