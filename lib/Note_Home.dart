import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_notes/add_new_list.dart';
import 'Login_page.dart';
import 'edit_existing_list.dart';

class home_note extends StatefulWidget {
  const home_note({Key? key}) : super(key: key);

  @override
  State<home_note> createState() => _home_noteState();
}

class _home_noteState extends State<home_note> {
  var colorsCard = [
    Color(0xffC4DACF),
    Color(0xff42995f),
  ];
  var colorsText = [
    Colors.black,
    Colors.red,
  ];

  List<Map<String, dynamic>> loginList = [];
  List noteList = [];
  var shared_pref; //sharedpref variable declaration

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
    dataget.docs.forEach((doc) {
      documentIds.add(doc);
    });
    // print(documentIds);
    setState(() {
      noteList = documentIds;
    });
    // print("xxxxxxxxxxxxxxxxxxxxxxxxx${documentIds[0]["id"]}");
  }

  Future<void>
      fchFireBaseLogin() //fetch login data from firestore in list map form
  async {
    var dataget = await FirebaseFirestore.instance.collection("login").get();
    List<Map<String, dynamic>> documentIds = [];
    dataget.docs.forEach((doc) {
      documentIds.add(doc.data());
    });
    //print(documentIds);
    setState(() {
      loginList = documentIds;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    shared_pref = id;
  }

  List<String> title = [];
  List<String> content = [];
  List<String> id = [];

  void titleContent() {
    noteList.forEach((element) {
      if (element.data()["id"] == shared_pref) {
        setState(() {
          title.add(element.data()["Title"]);
          content.add(element.data()["Content"]);
          id.add(element.id);
        });

        print(".........................${element["Content"]}");
      }
    });
  }

  month() {
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;
    String? letterMonth;

    if (currentMonth == 1) {
      letterMonth = "Jan";
    } else if (currentMonth == 2) {
      letterMonth = "Feb";
    } else if (currentMonth == 3) {
      letterMonth = "Mar";
    } else if (currentMonth == 4) {
      letterMonth = "Apr";
    } else if (currentMonth == 5) {
      letterMonth = "May";
    } else if (currentMonth == 6) {
      letterMonth = "Jun";
    } else if (currentMonth == 7) {
      letterMonth = "Jul";
    } else if (currentMonth == 8) {
      letterMonth = "Aug";
    } else if (currentMonth == 9) {
      letterMonth = "Sep";
    } else if (currentMonth == 10) {
      letterMonth = "Oct";
    } else if (currentMonth == 11) {
      letterMonth = "Nov";
    } else if (currentMonth == 12) {
      letterMonth = "Dec";
    }

    return letterMonth;
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
                                  margin: EdgeInsets.all(13),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "22",
                                            style: TextStyle(
                                                fontSize: 41,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: currentWidth / 27,
                                          ),
                                          Text(
                                            month(),
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: currentWidth / 16),
                                            child: Container(
                                              padding: EdgeInsets.all(14),
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
                                                              EdgeInsets.all(0),
                                                          children: [
                                                            Text(
                                                              title[index],
                                                              style: TextStyle(
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
                                                          child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black),
                                                          backgroundColor:
                                                              Colors.white,
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
                                                            EdgeInsets.all(5),
                                                        children: [
                                                          Text(content[index],
                                                              style: TextStyle(
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
                                  SizedBox(
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                      child: Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                           size: 21),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      heroTag: "yy",
                                    ),
                                    height: 41,
                                  ),
                                  FloatingActionButton(
                                    onPressed: () async {
                                    SharedPreferences prefData = await SharedPreferences.getInstance();
                                    await prefData.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              Login()),
                                    );
                                    },
                                    child: Icon(
                                      Icons.logout,
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
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
            heroTag: "dghhhhhhhhhhdfdhd f",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEdit()),
              );
            },
            child: Icon(Icons.add, size: 45),
            backgroundColor: Colors.black54,
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
