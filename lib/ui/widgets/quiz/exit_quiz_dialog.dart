import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitQuizDialog extends StatelessWidget {
  final Function()? onTapYes;

  const ExitQuizDialog({super.key, this.onTapYes});

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.nunito(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onTertiary,
      ),
    );

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Colors.transparent,
      content: Text(
        "do you want to exit",
        style: textStyle,
      ),
      actions: [
        CupertinoButton(
            child: Text(
              "Yes",
              style: textStyle,
            ),
            onPressed: () {
              if (onTapYes != null) {
                onTapYes!();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            }),
        CupertinoButton(
          onPressed: Navigator.of(context).pop,
          child: Text(
            "No",
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
