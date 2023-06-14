import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Note_Home.dart';

class AddEdit extends StatefulWidget {
  const AddEdit({Key? key}) : super(key: key);

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {


  TextEditingController title = TextEditingController();
  TextEditingController contents = TextEditingController();

  @override
  void initState() { //to run this functions at the starting of this page
    super.initState();
    monthNow();
  }

  var letterMonth;
  var dates;
  monthNow() {
    DateTime currentMonth = DateTime.now();
    String? letterMonthD;
    List<String> monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    letterMonthD = monthNames[currentMonth.month];
    DateTime currentDate = DateTime.now();
    int dataD = currentDate.day;
    letterMonth = letterMonthD;
    dates = dataD;
  }

  save()async
  {
    SharedPreferences sharedPreferences =await  SharedPreferences.getInstance();
    var id =sharedPreferences.getString("id");  //shared preference get data
    FirebaseFirestore.instance
        .collection("notes")
        .add({"Title": title.text, "Content": contents.text, "id": id, "date": dates, "month": letterMonth});
    return
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeNote()),
    );
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
              child: SingleChildScrollView(physics: const BouncingScrollPhysics(),
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
                        },
                        backgroundColor: Colors.black, child: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white)),
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

},backgroundColor: Colors.blueGrey,
                      child: const Icon(Icons.save),)
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
