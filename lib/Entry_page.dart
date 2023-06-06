import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_notes/Login_page.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
var mHeight = MediaQuery.of(context).size.height;
var mWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 4,
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://i.pinimg.com/564x/d2/5c/ec/d25cec03c8873f34f3a6ad92b7ef46f0.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              // color: Colors.redAccent,
            ),
          ),
          Expanded(flex: 3,
            child: Container(width: double.infinity,
              color: const Color(0xffecd3cc),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: mWidth/1.5,
                    child: Text("Create your notes easily",
                      style:  GoogleFonts.lato(fontSize: 45,fontWeight: FontWeight.w700,color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: mHeight/18,),
                  Container(width: mWidth/6,
                    height: mHeight/12.5,
                    decoration:
                    BoxDecoration(gradient: const LinearGradient(begin: Alignment.centerLeft,end: Alignment.topRight, colors: [Color(0xff03424C),Color(0xffE54C27)] ),
                        borderRadius: BorderRadius.circular(30)),
                    child: FloatingActionButton(onPressed: () {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                           builder: (context) {
                            return
                              Login();
                           },)
                     );

                    },
              backgroundColor: Colors.transparent,
                      elevation: 2,
                      child : Icon(Icons.arrow_forward_rounded,size: 35,color: Colors.orange[100]),
                     ),
                  )
                ],
              ),

            ),
          )
        ],
      ),
    );
  }
}
