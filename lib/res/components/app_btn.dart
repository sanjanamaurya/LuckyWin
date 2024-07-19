
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class AppBtn extends StatefulWidget {
  final String? title;
  final Color? titleColor;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool? loading;
  final Gradient? gradient;
  final bool hideBorder;
  final Widget? child;
  final FontWeight? fontWeight;
  final BoxBorder? border;
  final double borderRadius; // New parameter for border radius

  const AppBtn({
    Key? key,
    this.title,
    this.titleColor,
    this.onTap,
    this.width,
    this.height,
    this.fontSize,
    this.loading = false,
    this.gradient,
    this.hideBorder = false,
    this.child,
    this.fontWeight,
    this.border,
    this.borderRadius = 30.0, // Default border radius value
  }) : super(key: key);

  @override
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.3).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.loading == false
                ? Container(
              height: widget.height ?? 52,
              width: widget.width ?? MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                gradient: widget.gradient ?? AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.hideBorder == false
                      ? AppColors.gradientFirstColor
                      : Colors.transparent,
                  width: 0.5,
                ),
              ),
              child: widget.child ??
                  textWidget(
                    text: widget.title ?? 'Press me',
                    fontSize: widget.fontSize ?? 16,
                    color: widget.titleColor ?? AppColors.white,
                    fontWeight: widget.fontWeight ?? FontWeight.w600,
                  ),
            )
                : Center(
              child: Container(
                height: 45,
                width: 43,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.gradientFirstColor,
                      AppColors.gradientSecondColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                padding: const EdgeInsets.all(12),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



class AppBackBtn extends StatelessWidget {
  const AppBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,)
         // Image.asset(Assets.iconsArrowBack)
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? label;
  final TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final double? space;
  final double? iconSize;
  final List<BoxShadow>? boxShadow;
  bool? isClicked;
  final BoxShape? shape;
  final bool? inCol;
  final BoxBorder? border;
  PrimaryButton(
      {super.key, this.alignment,
        this.padding,
        this.color,
        this.decoration,
        this.width,
        this.height,
        this.margin,
        this.gradientColorOne,
        this.gradientColorTwo,
        this.shadowColor,
        this.dx,
        this.dy,
        this.gradient,
        this.label,
        this.style,
        this.icon,
        this.fontWeight,
        this.fontStyle,
        this.iconColor,
        this.textColor,
        this.fontSize,
        this.begin,
        this.end,
        this.blurRadius,
        this.spreadRadius,
        this.child,
        this.borderRadius,
        this.onTap,
        this.space,
        this.iconSize,
        this.boxShadow,
        this.isClicked,
        this.shape,
        this.inCol, this.border});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        // constraints: BoxConstraints(
        //   maxWidth: widths,
        //   minWidth: widths
        // ),
        margin: widget.margin,
        alignment: Alignment.center,
        padding: widget.padding,
        height: widget.height ?? 40,
        width: widget.width ?? widths,
        decoration: BoxDecoration(
            shape: widget.shape == null ? BoxShape.rectangle : widget.shape!,
            borderRadius:
            widget.borderRadius ?? BorderRadius.circular(10),
            color: widget.color ?? AppColors.primaryTextColor,
            gradient: widget.gradient,
            boxShadow: widget.boxShadow,
            border:widget.border
        ),
        child: widget.child ?? (widget.icon == null
            ? Text(
          widget.label == null ? "" : widget.label!,
          style:  TextStyle(
                  fontSize: widget.fontSize ?? MediaQuery.of(context).size.width/25,
                  color: widget.textColor ?? AppColors.primaryTextColor,
                  fontWeight: widget.fontWeight ?? FontWeight.w500),
          textAlign: TextAlign.center,
        )
            : widget.inCol == false
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.iconColor ?? AppColors.primaryTextColor,
              size: widget.iconSize,
            ),
            SizedBox(
              width: widget.space ?? 5,
            ),
            Text(
              widget.label == null ? "" : widget.label!,
              style: TextStyle(
                      fontSize: widget.fontSize ?? MediaQuery.of(context).size.width/25,
                      color: widget.textColor ?? AppColors.primaryTextColor,
                      fontWeight: widget.fontWeight ?? FontWeight.w500),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: widget.iconColor ?? AppColors.primaryTextColor,
              size: widget.iconSize,
            ),
            SizedBox(
              width: widget.space ?? 5,
            ),
            Text(
              widget.label == null ? "" : widget.label!,
              style:
                   TextStyle(
                      color: widget.textColor ?? AppColors.primaryTextColor,
                      fontSize: widget.fontSize ?? MediaQuery.of(context).size.width/25,
                      fontWeight: widget.fontWeight ?? FontWeight.w500),
            ),
          ],
        )),
      ),
    );
  }
}



class Text_Button extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final TextDecoration? decoration;

  const Text_Button({super.key, this.text, this.fontSize, this.fontWeight, this.textColor, this.onTap, this.padding, this.decoration}) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        padding: padding,
        child: Text(
            text==null?"Press Me!":text!,
            style: TextStyle(
                  fontSize: fontSize ?? MediaQuery.of(context).size.width/30,
                  fontWeight:fontWeight ?? FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: textColor ?? AppColors.btnColor,
                  decoration:decoration??TextDecoration.underline

            )),
      ),
    );

  }
}