import 'package:apptodo/pages/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  dynamic d = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    // Fetch and set the user's data when the page is loaded
    getuid();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            tooltip: 'Comment Icon',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const Add();
                },
              ));
            },
          ), //IconButton
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
              stream: firestore
                  .collection('file')
                  .doc(uid)
                  .collection('mytask')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  d = snapshot.data?.docs;
                  
                  return ListView.builder(
                    itemCount: d.length,
                    itemBuilder: (BuildContext context, int index) {
                      var time = (d[index]['Timestamp'] as Timestamp).toDate();

                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xff121211),
                            borderRadius: BorderRadius.circular(10)),
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    d[index]['Name'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                 Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                d[index]['Father'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 18, color: Colors.white),
                              ),
                            ),
                             Container(margin:
                                      const EdgeInsets.only(left: 30,),
                              
                              child: Text(
                                DateFormat.yMd().add_jm().format(time),
                                    style: GoogleFonts.roboto(
                                        fontSize: 18, color: Colors.white),
                              ),
                            )
                              ],
                            ),
                            Container(
                                child: IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                print(d[index]['time']);
                                await firestore
                                    .collection('file')
                                    .doc(uid)
                                    .collection('mytask')
                                    .doc(d[Index]['time'])
                                    .delete();
                                    
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            ),
                           
                          ],
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }
}
