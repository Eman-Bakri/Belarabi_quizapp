import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_with_eman/utils/constants/fonts.dart';

class UiUtils {
  static getImagePath(String imageName) {
    return "assets/images/$imageName";
  }

  static getProfileImagePath(String imageName) {
    return "assets/images/profile/$imageName";
  }

  static void setSnackBar(String msg, BuildContext context, bool showAction,
      {Function? onPressedAction, Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: showAction ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.nunito(
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeights.regular,
            fontSize: 16,
          ),
        ),
        behavior: SnackBarBehavior.fixed,
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: Theme.of(context).primaryColor,
        action: showAction
            ? SnackBarAction(
                label: "Retry", onPressed: onPressedAction as void Function())
            : null,
        elevation: 2.0,
      ),
    );
  }

  static void vibrate() {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
  }

  static const profileHeightBreakPointResultScreen = 355.0;

  static bool isArabic(BuildContext context) {
    // return Locale(context.read<SettingsCubit>().getSettings().languageCode) ==
    //     const Locale('ar');
    return context.locale == const Locale('ar');
  }

  static const bottomSheetTopRadius = BorderRadius.vertical(
    top: Radius.circular(20),
  );
}
