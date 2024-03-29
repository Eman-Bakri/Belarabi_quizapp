import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/constants/fonts.dart';
import '../../../utils/normalize_number.dart';

class RadialPercentageResultContainer extends StatefulWidget {
  final Size size;
  final double percentage;
  final double circleStrokeWidth;
  final double arcStrokeWidth;
  final Color? circleColor;
  final Color? arcColor;
  final double? textFontSize;
  final double radiusPercentage; //respect to width

  const RadialPercentageResultContainer({
    super.key,
    required this.percentage,
    required this.size,
    this.textFontSize,
    this.circleStrokeWidth = 8.0,
    this.arcStrokeWidth = 8.0,
    this.radiusPercentage = 0.27,
    this.arcColor,
    this.circleColor,
  });

  @override
  State<RadialPercentageResultContainer> createState() =>
      _RadialPercentageResultContainerState();
}

class _RadialPercentageResultContainerState
    extends State<RadialPercentageResultContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(
            begin: 0.0,
            end: NormalizeNumber.inRange(
                currentValue: widget.percentage,
                minValue: 0.0,
                maxValue: 100.0,
                newMaxValue: 360.0,
                newMinValue: 0.0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.size.height,
          width: widget.size.width,
          child: CustomPaint(
            painter: CircleCustomPainter(
              color: widget.circleColor ??
                  Theme.of(context).scaffoldBackgroundColor,
              radiusPercentage: widget.radiusPercentage,
              strokeWidth: widget.circleStrokeWidth,
            ),
          ),
        ),
        SizedBox(
          height: widget.size.height,
          width: widget.size.width,
          child: AnimatedBuilder(
            builder: (context, _) {
              return CustomPaint(
                willChange: false,
                painter: ArcCustomPainter(
                  sweepAngle: animation.value,
                  color: Theme.of(context).primaryColor,
                  radiusPercentage: widget.radiusPercentage,
                  strokeWidth: widget.arcStrokeWidth,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 2.5),
                      child: Text(
                        "${widget.percentage.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: widget.textFontSize ?? 17.0,
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontWeight: FontWeights.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            animation: animationController,
          ),
        )
      ],
    );
  }
}

class CircleCustomPainter extends CustomPainter {
  final Color? color;
  final double? strokeWidth;
  final double? radiusPercentage;

  CircleCustomPainter({this.color, this.radiusPercentage, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * (0.5), size.height * (0.5));
    Paint paint = Paint()
      ..strokeWidth = strokeWidth!
      ..color = color!
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, size.width * radiusPercentage!, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //generally it return false but when parent widget is changing
    //or animating it should return true
    return false;
  }
}

class ArcCustomPainter extends CustomPainter {
  final double sweepAngle;
  final Color color;
  final double radiusPercentage;
  final double strokeWidth;

  ArcCustomPainter({
    required this.sweepAngle,
    required this.color,
    required this.radiusPercentage,
    required this.strokeWidth,
  });

  double _degreeToRadian() => -((sweepAngle * pi) / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(
          size.width * (0.5),
          size.height * (0.5),
        ),
        radius: size.width * radiusPercentage,
      ),
      3 * (pi / 2),
      _degreeToRadian(),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
