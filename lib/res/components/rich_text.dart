import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final List<CustomTextSpan> textSpans;
  final TextAlign? textAlign;

  const CustomRichText({
    super.key,
    required this.textSpans,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [];
    for (CustomTextSpan span in textSpans) {
      children.add(
        TextSpan(
          text: span.text,
          style:
            TextStyle(
              fontSize: span.fontSize ?? 12,
              fontWeight: span.fontWeight ?? FontWeight.normal,
              fontStyle: FontStyle.normal,
              color: span.textColor ?? Colors.black,
              overflow: TextOverflow.ellipsis,
              height: 1.5,
            ),

          recognizer: TapGestureRecognizer()..onTap = span.spanTap,
        ),
      );
    }

    return RichText(
      textAlign: textAlign ?? TextAlign.left,
      text: TextSpan(children: children),
    );
  }
}

class CustomTextSpan {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? spanTap;

  CustomTextSpan({
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.spanTap,
  });
}
