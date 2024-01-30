import 'dart:async';

import 'package:flutter/material.dart';

import '../../../common/c_button.dart';
import '../../../common/themes/c_colors.dart';
import '../../../common/themes/c_textstyle.dart';

class DialogService {
  static Future<dynamic> showDialogWithAction(
    BuildContext context, {
    required Widget icon,
    String? description,
    String? subDescription,
    String? buttonText,
    VoidCallback? onPressedButton,
    TextStyle? buttonTextStyle,
    TextStyle? subDescriptionTextStyle,
    double borderRadius = 6,
    bool isLandscape = false,
    bool barrierDismissible = true,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: isLandscape
              ? EdgeInsets.symmetric(
                  horizontal: (screenWidth - 210) / 2,
                  vertical: 24,
                )
              : const EdgeInsets.symmetric(horizontal: 40),
          elevation: 0,
          backgroundColor: Colors.white,
          child: RotatedBox(
            quarterTurns: isLandscape ? 1 : 0,
            child: SizedBox(
              width: isLandscape ? 320 : null,
              child: _DialogWidget2(
                borderRadius: borderRadius,
                icon: icon,
                buttonText: buttonText,
                buttonTextStyle: buttonTextStyle,
                description: description,
                descriptionTextStyle: subDescriptionTextStyle,
                onPressedButton: onPressedButton,
                subDescription: subDescription,
                subDescriptionTextStyle: subDescriptionTextStyle,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showActionDialog(
    BuildContext context, {
    String? leftButtonText,
    String? rightButtonText,
    VoidCallback? onPressedLeftButton,
    VoidCallback? onPressedRightButton,
    String? description,
    TextStyle? descriptionTextStyle,
    TextStyle? leftButtonTextStyle,
    TextStyle? rightButtonTextStyle,
    double borderRadius = 6,
    bool isLandscape = false,
    bool barrierDismissible = true,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: isLandscape
              ? EdgeInsets.symmetric(
                  horizontal: (screenWidth - 172) / 2,
                  vertical: 24,
                )
              : const EdgeInsets.symmetric(horizontal: 40),
          elevation: 0,
          backgroundColor: Colors.white,
          child: RotatedBox(
            quarterTurns: isLandscape ? 1 : 0,
            child: SizedBox(
              width: isLandscape ? 320 : null,
              child: _DialogWidget(
                leftButtonTextStyle: leftButtonTextStyle,
                leftButtonText: leftButtonText,
                onPressedLeftButton: onPressedLeftButton,
                description: description,
                descriptionTextStyle: descriptionTextStyle,
                rightButtonText: rightButtonText,
                onPressedRightButton: onPressedRightButton,
                rightButtonTextStyle: rightButtonTextStyle,
                borderRadius: borderRadius,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DialogWidget extends StatefulWidget {
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? onPressedLeftButton;
  final VoidCallback? onPressedRightButton;
  final String? description;
  final TextStyle? descriptionTextStyle;
  final TextStyle? leftButtonTextStyle;
  final TextStyle? rightButtonTextStyle;
  final double? borderRadius;

  const _DialogWidget({
    this.leftButtonText,
    this.rightButtonText,
    this.onPressedLeftButton,
    this.onPressedRightButton,
    this.description,
    this.descriptionTextStyle,
    this.leftButtonTextStyle,
    this.rightButtonTextStyle,
    this.borderRadius,
  });

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<_DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.description != null
              ? Text(
                  widget.description ?? "",
                  textAlign: TextAlign.center,
                  style: widget.descriptionTextStyle ??
                      CTextStyles.base.s14.w300(),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: CButton(
                    isOutlined: true,
                    verticalPadding: 0,
                    title: widget.leftButtonText ?? "OK",
                    onPressed: () {
                      widget.onPressedLeftButton?.call();
                      Navigator.pop(context);
                    },
                    borderRadius: widget.borderRadius ?? 2,
                    textColor: CColors.primaryA500,
                    textStyle: widget.leftButtonTextStyle ??
                        CTextStyles.base.s14.w300(),
                  ),
                ),
                widget.rightButtonText != null
                    ? const SizedBox(
                        width: 16,
                      )
                    : const SizedBox.shrink(),
                widget.rightButtonText != null
                    ? Expanded(
                        child: CButton(
                          verticalPadding: 0,
                          title: widget.rightButtonText ?? "",
                          onPressed: () {
                            widget.onPressedRightButton?.call();
                            Navigator.pop(context);
                          },
                          borderRadius: widget.borderRadius ?? 2,
                          textStyle: widget.rightButtonTextStyle ??
                              CTextStyles.base.s14.w300(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------------------------------------------------------------

class _DialogWidget2 extends StatefulWidget {
  final String? buttonText;
  final VoidCallback? onPressedButton;
  final String? description;
  final String? subDescription;
  final TextStyle? descriptionTextStyle;
  final TextStyle? subDescriptionTextStyle;
  final TextStyle? buttonTextStyle;
  final double? borderRadius;
  final Widget icon;

  const _DialogWidget2({
    required this.icon,
    this.onPressedButton,
    this.description,
    this.descriptionTextStyle,
    this.buttonTextStyle,
    this.borderRadius,
    this.buttonText,
    this.subDescription,
    this.subDescriptionTextStyle,
  });

  @override
  _DialogWidget2State createState() => _DialogWidget2State();
}

class _DialogWidget2State extends State<_DialogWidget2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.icon,
          const SizedBox(height: 10),
          if (widget.description != null) ...[
            Text(
              widget.description ?? "",
              textAlign: TextAlign.center,
              style: widget.descriptionTextStyle ?? CTextStyles.base.s14.w700(),
            ),
            const SizedBox(height: 4),
          ],
          if (widget.subDescription != null) ...[
            Text(
              widget.subDescription ?? "",
              textAlign: TextAlign.center,
              style:
                  widget.subDescriptionTextStyle ?? CTextStyles.base.s12.w300(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
          ],
          CButton(
            isOutlined: false,
            verticalPadding: 0,
            title: widget.buttonText ?? "OK",
            onPressed: () {
              widget.onPressedButton?.call();
              Navigator.pop(context);
            },
            borderRadius: widget.borderRadius ?? 2,
            textColor: CColors.white,
            textStyle: widget.buttonTextStyle ?? CTextStyles.base.s14.w300(),
          ),
        ],
      ),
    );
  }
}
