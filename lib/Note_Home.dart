import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_notes/add_new_list.dart';
import 'Login_page.dart';
import 'edit_existing_list.dart';

class HomeNote extends StatefulWidget {
  const HomeNote({Key? key}) : super(key: key);

  @override
  State<HomeNote> createState() => HomeNoteState();
}

class HomeNoteState extends State<HomeNote> {
  var colorsCard = [
    const Color(0xffC4DACF),
    const Color(0xff42995f),
  ];
  var colorsText = [
    Colors.black,
    Colors.red,
  ];

  List<Map<String, dynamic>> loginList = [];
  List noteList = [];
  var sharedPref; //sharedpref variable declaration

  @override
  void initState() { //to run this functions at the starting of this page
    super.initState();
    fullFunction();
    // print(".............$shared_pref");
  }

  Future<void> fullFunction() async {

    await fchFireBaseNote();
    await fchFireBaseLogin();
    titleContent();

  }

  Future<void>
      fchFireBaseNote() //fetch notes data from firestore in list map form
  async {
    var dataget = await FirebaseFirestore.instance.collection("notes").get();
    List documentIds = [];
    for (var doc in dataget.docs) {
      documentIds.add(doc);
    }
    // print(documentIds);
    setState(() {
      noteList = documentIds;
    });
  }

  Future<void>
      fchFireBaseLogin() //fetch login data from firestore in list map form
  async {
    var dataget = await FirebaseFirestore.instance.collection("login").get();
    List<Map<String, dynamic>> documentIds = [];
    for (var doc in dataget.docs) {
      documentIds.add(doc.data());
    }
    //print(documentIds);
    setState(() {
      loginList = documentIds;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    sharedPref = id;
  }

  List<String> title = [];
  List<String> content = [];
  List<String> id = [];
  List<int> date = [];
  List<String> month = [];

  void titleContent() {
    for (var element in noteList) {
      if (element.data()["id"] == sharedPref) {
        setState(() {
          title.add(element.data()["Title"]);
          content.add(element.data()["Content"]);
          date.add(element.data()["date"]);
          month.add(element.data()["month"]);
          id.add(element.id);
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    var currentHight = MediaQuery.of(context).size.height;
    var currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
              height: currentHight,
              width: currentWidth,
              color: Colors.grey[800],
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: currentWidth / 1.2,
                    child: ListView.builder(
                      itemCount: title.length,
                      padding: EdgeInsets.only(top: currentHight / 4.18),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: currentHight / 6,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: colorsCard[index % colorsCard.length]),
                              child: Container(
                                  color: Colors.transparent,
                                  margin: const EdgeInsets.all(13),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(height: currentHight/16,width: currentWidth/7.5,
                                            child: Center(
                                              child: Text(
                                                date[index].toString(),
                                                style: const TextStyle(
                                                    fontSize: 41,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: currentWidth / 58,
                                          ),
                                          SizedBox(height: currentHight/18,width: currentWidth/7,
                                            child: Center(
                                              child: Text(
                                                month[index],
                                                style: const TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: currentWidth / 16),
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              height: currentHight / 8.12,
                                              width: currentWidth / 2.6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                color: Colors.black,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            currentWidth / 5.9,
                                                        height:
                                                            currentHight / 33,
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          padding:
                                                              const EdgeInsets.all(0),
                                                          children: [
                                                            Text(
                                                              title[index],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            currentHight / 25,
                                                        child:
                                                            FloatingActionButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditList(
                                                                            title:
                                                                                title[index],
                                                                            content:
                                                                                content[index],
                                                                            id: id[index],
                                                                          )),
                                                            );
                                                          },
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          currentHight / 155),
                                                  Container(
                                                    height: currentHight / 24,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[900],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: ListView(
                                                        padding:
                                                            const EdgeInsets.all(5),
                                                        children: [
                                                          Text(content[index],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                        ]),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                        height: currentHight / 4,
                        width: currentWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SafeArea(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FloatingActionButton(
                                    onPressed: () async {
                                    SharedPreferences prefData = await SharedPreferences.getInstance();
                                    await prefData.clear();
                                    {
                                      Future.delayed(Duration.zero, () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => const Login()),
                                        );
                                      });
                                    }

                                    },
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: const Icon(
                                      Icons.logout,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: currentWidth / 29,
                                ),
                                Text("NOTE",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey[300],
                                        fontSize: 41,
                                        height: 2,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              )),
          FloatingActionButton(
            heroTag: "dghhhhhhhhhhdfdhdf",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEdit()),
              );
            },
            backgroundColor: Colors.black54,
            child: const Icon(Icons.add, size: 45),
          )
        ],
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
