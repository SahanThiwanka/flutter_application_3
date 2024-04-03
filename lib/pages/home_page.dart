import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_application_3/pages/data_retrive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event){
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Sign In"),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(child: SizedBox(
      height: 50,
      child: SignInButton(Buttons.google, text: "Sign in with Google", onPressed: _handleGoogleSignIn,),
    ),);
  }

  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:[Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(_user!.photoURL!),
          ),
          ),
        ),
        Text(_user!.displayName ?? ""),
        Text(_user!.email!),
        MaterialButton(
          color: Colors.red,
          child: Text("Sign Out"),
          onPressed: _auth.signOut,
        ),
        SizedBox(height: 10), // Add some spacing between buttons
        MaterialButton(
          color: Colors.blue,
          child: Text("Go to Product List"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProducListPage()),
            );
          },
        ),
        ],
    ),
    
    );
    
  }

  void _handleGoogleSignIn(){
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    }catch (error) {
    print(error);
    }
  }



}