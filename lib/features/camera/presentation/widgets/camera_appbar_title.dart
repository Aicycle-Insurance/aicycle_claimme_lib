import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../enum/car_part_direction.dart';
import '../../../../generated/locales.g.dart';
import '../../../../common/extension/translation_ext.dart';
import '../../../../common/themes/c_colors.dart';
import '../../../../common/themes/c_textstyle.dart';

class CameraAppBarTitle extends StatelessWidget {
  const CameraAppBarTitle(
      {super.key,
      required this.onPop,
      required this.carPartDirectionEnum,
      required this.onGalleryPicker,
      this.title,
      this.orientation = DeviceOrientation.portraitUp});
  final Function() onPop;
  final CarPartDirectionEnum carPartDirectionEnum;
  final Function() onGalleryPicker;
  final String? title;
  final DeviceOrientation? orientation;

  @override
  Widget build(BuildContext context) {
    double rotate = 0;
    switch (orientation) {
      case DeviceOrientation.portraitUp:
        rotate = 0;
        break;
      case DeviceOrientation.landscapeLeft:
        rotate = 1 / 4;
        break;
      default:
        rotate = 0;
        break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPop,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocaleKeys.close.trans.toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              title ?? carPartDirectionEnum.title,
              style: CTextStyles.base.whiteColor.s16.w500(),
            ),
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          // minSize: 0,
          onPressed: onGalleryPicker,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CColors.inkA100,
              border: Border.all(width: 1, color: CColors.inkA100),
            ),
            padding: const EdgeInsets.all(10),
            child: AnimatedRotation(
              turns: rotate,
              duration: const Duration(milliseconds: 300),
              child: const Icon(
                CupertinoIcons.photo_on_rectangle,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
