import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

//Sign-in-----------------------------------------------------------------------------------

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  final FirebaseUser currentUser = await _auth.currentUser();

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

//------------------------------------------------------------------------------------------

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: new Color(0xffe23149),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenHeight * 1 / 6.7),
              Image.asset(
                "assets/runr.png",
                height: 3 / 4 * ScreenWidth,
                width: 3 / 4 * ScreenWidth,
              ),
              SizedBox(height: ScreenHeight * 1 / 10),
              _signInButton(),
              SizedBox(height: 19),
              Text("Forgot Password?", style: TextStyle(color: Colors.white)),
              SizedBox(
                  height: ScreenHeight -
                      (ScreenHeight * 1 / 6.7 +
                          3 / 4 * ScreenWidth +
                          ScreenHeight * 1 / 10 +
                          160)),
              Text("Runr © LLC 2020", style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  //just to push

  Widget _signInButton() {
    return RaisedButton(
      color: Colors.white,
      splashColor: Colors.lightBlue,
      onPressed: () {
        signInWithGoogle().then((FirebaseUser user) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage(user);
              },
            ),
          );
        }).catchError((e) => print(e));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
