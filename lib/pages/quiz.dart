//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}
// This widget is the root of your application.
class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2a2b31),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0, left: 20.0),
              child: Row(
                children: [
                Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                child: Center(child: Icon(Icons.arrow_back_ios_outlined, color: Color(0xFF2a2b31),),)),
                SizedBox(width: 125.0,),
                Text("مصر", style: TextStyle(color: Colors.white, fontSize: 33.0, fontWeight: FontWeight.bold, fontFamily: "Amiri"),)
                      ],),
            ),
        SizedBox(height: 20.0,),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height/1.15,
            //width: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("images/Egypt4.png", height: 280, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text("ما معنى الكلمة --- باللّهجة المصريّة ؟", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: "Amiri"),),
              ),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
                child: Text("الاختيار الأول", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500, fontFamily: "Amiri",),),
              ),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
                child: Text("الاختيار الثّاني", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500, fontFamily: "Amiri",),),
              ),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
                child: Text("الاختيار الثّالث", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500, fontFamily: "Amiri",),),
              ),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
                child: Text("الاختيار الرّابع", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500, fontFamily: "Amiri",),),
              ),
            ],),
          ),
        ),
      ],),),
    );
  }
}