import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/ui_utils.dart';
import 'custom_rounded_button.dart';

class ErrorContainer extends StatelessWidget {
  final String? errorMessage; // TODO: make it required
  final Function onTapRetry;
  final bool showErrorImage, showRTryButton;
  final double topMargin;
  final Color? errorMessageColor;
  final bool? showBackButton;

  const ErrorContainer({
    super.key,
    this.errorMessageColor,
    required this.errorMessage,
    required this.onTapRetry,
    required this.showErrorImage,
    this.topMargin = 0.1,
    this.showBackButton,
    this.showRTryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * topMargin),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showErrorImage) ...[
            SvgPicture.asset(
              UiUtils.getImagePath("error.svg"),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 25.0),
          ],
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              // TODO : Refactor Everywhere for AppLocalization.of(context)!.getTranslatedValues(errorMessage) ?? errorMessage
              "$errorMessage :(",
              style: TextStyle(
                  fontSize: 18.0,
                  color: errorMessageColor ??
                      Theme.of(context).colorScheme.onTertiary),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 25.0),
          showRTryButton
              ? CustomRoundedButton(
                  widthPercentage: 0.375,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  buttonTitle: "Retry",
                  radius: 5,
                  showBorder: false,
                  height: 40,
                  titleColor: Theme.of(context).colorScheme.onTertiary,
                  elevation: 5.0,
                  onTap: onTapRetry,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
