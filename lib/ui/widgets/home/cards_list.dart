// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class CategoryCards extends StatefulWidget {
  final List<Map<String, String>> content;
  final String categoryName;
  final Duration categoryDelayAnimation;
  final Duration categoryPlayAnimation;
  const CategoryCards({
    Key? key,
    required this.content,
    required this.categoryName,
    required this.categoryDelayAnimation,
    required this.categoryPlayAnimation,
  }) : super(key: key);

  @override
  State<CategoryCards> createState() => _CategoryCardsState();
}

class _CategoryCardsState extends State<CategoryCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                widget.categoryName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "View all",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: widget.content
                .map((name) => GestureDetector(
                      onTap: () {
                        context.go("/home/quiz", extra: {
                          "language": "english",
                          "category": widget.categoryName,
                          "subcatgeory": name['name'],
                          "level": "level 1"
                        });
                        // "/home/quiz/english/${widget.categoryName}/${name['name']}/level1");
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  name["image"] ?? "",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  name["name"] ?? "",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          )
                          // child: Container(
                          //   height: 100,
                          //   width: 100,
                          //   color: Colors.red,
                          // ),
                          ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    )
        .animate()
        .slideX(
          begin: 0.2,
          end: 0,
          duration: widget.categoryPlayAnimation,
          delay: widget.categoryDelayAnimation,
          curve: Curves.fastOutSlowIn,
        )
        .fadeIn();
  }
}
