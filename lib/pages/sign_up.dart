import 'package:apptodo/pages/home.dart';
import 'package:apptodo/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void buttonregister() async {
    final dynamic email = emailController.text;
    final dynamic password = passwordController.text;
    final String user = usernameController.text;

    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await firestore.collection('file').doc(credential.user!.uid).set({
        'name': user,
        'email': email,
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const Home();
        },
      ));
    } catch (e) {
      print(e.toString());
    }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 110, 184, 62),
              Color.fromARGB(255, 181, 184, 187),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Account!',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'User-name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  style:const TextStyle(color: Colors.white),
                  decoration:const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 216, 52, 52)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  obscureText: true,
                ),
               const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: buttonregister,
                  child: const Text('Sign up'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(190, 22, 16, 16), backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                 const SizedBox(height: 10.0),
                 Row(
                  children: [
                    const Padding(
                   padding: EdgeInsets.only(left:30.0),
                   child: Text('Already have an account?'),
                 ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                
                child: const Text(
                  ' Log in',
                  style: TextStyle(color: Color.fromARGB(255, 214, 114, 114),fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),

                  ],
                 )
                 
              ],
            ),
          ),
        ),
      ),

    );
  }
}