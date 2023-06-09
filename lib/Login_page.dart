import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Note_Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

}
class _LoginState extends State<Login> {
  bool LoginSignUp = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();

  // getId()
  // async {
  //   var Dataget = await FirebaseFirestore.instance.collection("notes").get();
  //   List<String> documentIds = [];
  //   Dataget.docs.forEach((doc) {
  //     documentIds.add(doc.id);
  //   });
  //
  //   // var a = Dataget.docs[0].data();
  //   print(documentIds);
  //
  // }

  Check_name() {
    // print("........................................$name");
    if (name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child:
                Text("Enter your name", style: TextStyle(color: Colors.red))),
        backgroundColor: Colors.white,
      ));
    } else {
      SignUp_FireAuth();
    }
  }

  void Login_fireAuth() async {
    try {
   var login =    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
   SharedPreferences sharedPreferences =await  SharedPreferences.getInstance();
   await sharedPreferences.setString("id", login.user!.uid);
   await sharedPreferences.setBool("looged", true);
   print(login);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => home_note())
      );
    } on FirebaseAuthException catch (e) {
      String error = e.toString();
      if (error.contains("Given String is empty or null")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text("Enter Email/password",
                  style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }
      if (error.contains(
          "The password is invalid or the user does not have a password")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child:
                  Text("Wrong password", style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }
      if (error.contains(
          "There is no user record corresponding to this identifier. The user may have been deleted")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text("User does not exist",
                  style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }
    }
  }
var SignId ;
  SignUp_FireAuth() async {
    try {
    var sighupId =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: pass.text);
     var details =  await FirebaseFirestore.instance
          .collection("login").add({"email": email.text,"name": name.text,"id":sighupId.user!.uid} );

        SignId  = sighupId.user!.uid;
    SharedPreferences sharedPreferences =await  SharedPreferences.getInstance();
    await sharedPreferences.setString("id", SignId);
    await sharedPreferences.setBool("looged", true);
        print("...............................................${sighupId.user!.uid}");
      setState(() {
        LoginSignUp = false;
      });
    } on FirebaseAuthException catch (e) {
      String error = e.toString();
      if (error
          .contains("The email address is already in use by another account")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text("Email adress already exist",
                  style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }
      if (error.contains("The email address is badly formatted")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text("Format of email is not correct",
                  style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }

      if (error.contains("Password should be at least 6 characters")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text("Password should be at least 6 characters",
                  style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }
      if (error.contains("Given String is empty or null")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text("Email/Password is missing",
                  style: TextStyle(color: Colors.red))),
          backgroundColor: Colors.white,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentWith = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: currentWith,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Stack(children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pinimg.com/564x/d2/5c/ec/d25cec03c8873f34f3a6ad92b7ef46f0.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 30),
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.orange[500],
                            size: 30,
                          ),

                        ))
                  ]),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          LoginSignUp != true
                              ? Text("Welcome Back",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff3f734d)))
                              : Text("Welcome",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff3f734d))),
                          const SizedBox(
                            height: 5,
                          ),
                          LoginSignUp != true
                              ? Text("Login to your account",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[400]))
                              : Text("Create a new account",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[400]))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: LoginSignUp != true
                      ?

                      //..........................login...........................

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 35, top: 35),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffC6DCD1)),
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 50, top: 3),
                                child: TextField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color(0xff376F47)),
                                      hintText: "Email",
                                      icon: Icon(Icons.person,
                                          color: Color(0xff376F47)),
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 35, right: 35),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffC6DCD1)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 50, top: 3),
                                child: TextField(
                                  controller: pass,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color(0xff376F47)),
                                      hintText: "Password",
                                      icon: Icon(Icons.lock,
                                          color: Color(0xff376F47)),
                                      enabledBorder: InputBorder.none),
                                ),
                              ),

                            ),
                          ),
                        ],
                      )
                      :

                      //..................signup................................

                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 35, right: 35),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffC6DCD1)),
                                  height: 55,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 50, top: 3),
                                    child: TextField(
                                      controller: name,
                                      decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Color(0xff376F47)),
                                          hintText: "Name",
                                          icon: Icon(Icons.person,
                                              color: Color(0xff376F47)),
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 35, top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffC6DCD1)),
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 50, top: 3),
                                child: TextField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color(0xff376F47)),
                                      hintText: "Email",
                                      icon: Icon(Icons.person,
                                          color: Color(0xff376F47)),
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 35, top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffC6DCD1)),
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 50, top: 3),
                                child: TextField(
                                  controller: pass,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color(0xff376F47)),
                                      hintText: "Password",
                                      icon: Icon(Icons.lock,
                                          color: Color(0xff376F47)),
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                            ],
                          ),
                       ),

              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.topRight,
                                colors: [Colors.greenAccent, Colors.green]),
                            borderRadius: BorderRadius.circular(30)),
                        child:
                        FloatingActionButton.extended(
                          onPressed: () {
                            LoginSignUp != false
                                ? Check_name()
                                : Login_fireAuth();
                          },
                          label: LoginSignUp != true
                              ? Text("Login",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))
                              : Text("Signup",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                          backgroundColor: Colors.transparent,
                          elevation: 1,
                          heroTag: "x",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoginSignUp != true
                              ? const Text("don't have account?",
                                  style: TextStyle(color: Colors.grey))
                              : const Text("already have an account?",
                                  style: TextStyle(color: Colors.grey)),
                          LoginSignUp != true
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      LoginSignUp = true;
                                    });
                                  },
                                  child: Text("Sign up"))
                              : TextButton(
                                  onPressed: () {
                                    setState(() {
                                      LoginSignUp = false;
                                    });
                                  },
                                  child: Text("Login")),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height + 5);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 35.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 70);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 70);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
