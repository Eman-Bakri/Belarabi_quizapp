import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
// This widget is the root of your application.
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffedf3f6),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Stack(children: [
                Container(
                    height: 220,
                    padding: EdgeInsets.only(left: 20.0, top: 50.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF2a2b31), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(60),),
                            Padding(
                                padding: const EdgeInsets.only(top: 10.0)),
                    ],),
                  ),
                  Container(
                    //decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 120.0, left: 20.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20),) ,
                            child: Image.asset("images/black.png", height: 210, width: 370, fit: BoxFit.fill,))
                      ],
                    ),
                  )
                ] ),
                SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text("اختر واحدة من فئات اللّهجات", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: "Amiri"),),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                    child: Wrap(
                      spacing: 44.0,
                      runSpacing: 32.0,
                      alignment: WrapAlignment.center,
                      children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5.0,
                        child: Container(
                            width: 150,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Image.asset("images/Egypt4.png", height: 80, width: 80, fit: BoxFit.cover,),
                                SizedBox(height: 20.0,),
                                Text("مصر", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w500, fontFamily: "Amiri"),),
                              ],
                            )),
                      ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5.0,
                          child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Image.asset("images/Morroco4.png", height: 80, width: 80, fit: BoxFit.cover,),
                                  SizedBox(height: 20.0),
                                  Text("المغرب", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w500, fontFamily: "Amiri"),),
                                ],
                              )),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5.0,
                          child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Image.asset("images/Syrian1.png", height: 80, width: 80, fit: BoxFit.cover,),
                                  SizedBox(height: 20.0,),
                                  Text("سوريا", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w500, fontFamily: "Amiri"),),
                                ],
                              )),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5.0,
                          child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Image.asset("images/Saudi2.png", height: 80, width: 80, fit: BoxFit.cover,),
                                  SizedBox(height: 20.0,),
                                  Text("السّعوديّة", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w500, fontFamily: "Amiri"),),
                                ],
                              )),
                        ),
                    ],),
                  )
              ],)
          ),
        )
    );
  }
}