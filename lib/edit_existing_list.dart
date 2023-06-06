import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Note_Home.dart';

class EditList extends StatefulWidget {
  String? title;
  String? content;
  String? id;
   EditList({Key? key,required this.title,required this.content,required this.id}) : super(key: key);

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {


  TextEditingController title = TextEditingController();
  TextEditingController contents = TextEditingController();

  void save()
   {
     FirebaseFirestore.instance.collection("notes").doc(widget.id).update({"Title": title.text, "Content": contents.text});
     Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => home_note())
     );
  }

  @override
  void initState() {
    title.text = widget.title.toString();
    contents.text = widget.content.toString();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var currentHeight = MediaQuery.of(context).size.height;
    var currentWidth = MediaQuery.of(context).size.height;



    return Scaffold(
        body: Stack(
            children: [
              ClipPath(clipper: WaveClipper(),
                  child: Container(height: currentHeight/4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/d2/5c/ec/d25cec03c8873f34f3a6ad92b7ef46f0.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Center(
                child: SingleChildScrollView(physics: BouncingScrollPhysics(),
                  child: SizedBox(
                    width: currentWidth/2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: currentHeight/9),
                        Container(alignment: Alignment.topLeft,
                          child: FloatingActionButton(elevation: 0,
                              onPressed: () {
                                Navigator.pop(context);
                              },child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white),
                              backgroundColor: Colors.black),
                        ),
                        SizedBox(height: currentHeight/15,),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffC6DCD1)),
                            height: currentHeight/15,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 50, top: 3),
                              child: TextField(
                                controller: title,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff376F47)),
                                    hintText: "Title",
                                    icon: Icon(Icons.title, color: Color(0xff376F47)),
                                    enabledBorder: InputBorder.none),
                              ),
                            )),
                        SizedBox(
                          height: currentHeight/19,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffC6DCD1)),

                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 50, top: 3),
                              child: TextField(maxLines: 12,
                                controller: contents,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff376F47)),
                                    hintText: "Enter notes",
                                    enabledBorder: InputBorder.none),
                              ),
                            )),
                        SizedBox(height: currentHeight/21),
                        FloatingActionButton(onPressed: ()  {
                          save();

                        },
                          child: Icon(Icons.save),backgroundColor: Colors.blueGrey,)
                      ],
                    ),
                  ),
                ),
              ),]
        )
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
