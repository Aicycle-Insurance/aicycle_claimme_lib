import 'package:flutter/material.dart';

import '../../../../common/extension/translation_ext.dart';
import '../../../../common/themes/c_textstyle.dart';
import '../../../../enum/car_part_direction.dart';
import '../../../../generated/locales.g.dart';

class DirectionInfoLayer extends StatefulWidget {
  const DirectionInfoLayer({
    super.key,
    required this.rangeShot,
    required this.carPartDirectionEnum,
    required this.onAngleCallBack,
  });
  final String rangeShot;
  final CarPartDirectionEnum carPartDirectionEnum;
  final Function(CarPartDirectionEnum)? onAngleCallBack;

  @override
  State<DirectionInfoLayer> createState() => _DirectionInfoLayerState();
}

class _DirectionInfoLayerState extends State<DirectionInfoLayer> {
  final GlobalKey dropDownKey = GlobalKey();
  final String straightFrame = LocaleKeys.straightFrame.trans;
  final String d45Frame = LocaleKeys.d45Frame.trans;
  late CarPartDirectionEnum currentAngle;
  bool showDropDown = false;

  @override
  initState() {
    super.initState();
    currentAngle = widget.carPartDirectionEnum;
  }

  Map<CarPartDirectionEnum, String> get anglesShot {
    Map<CarPartDirectionEnum, String> result = {};
    switch (widget.carPartDirectionEnum) {
      case CarPartDirectionEnum.up:
        result[widget.carPartDirectionEnum] = straightFrame;
        break;
      case CarPartDirectionEnum.front:
        result[widget.carPartDirectionEnum] = straightFrame;
        break;
      case CarPartDirectionEnum.d45RightFront:
        result[widget.carPartDirectionEnum] = d45Frame;
        result[CarPartDirectionEnum.rightFront] = straightFrame;
        break;
      case CarPartDirectionEnum.d45LeftFront:
        result[widget.carPartDirectionEnum] = d45Frame;
        result[CarPartDirectionEnum.leftFront] = straightFrame;
        break;
      case CarPartDirectionEnum.back:
        result[widget.carPartDirectionEnum] = straightFrame;

        break;
      case CarPartDirectionEnum.d45RightBack:
        result[widget.carPartDirectionEnum] = d45Frame;
        result[CarPartDirectionEnum.rightBack] = straightFrame;
        break;
      case CarPartDirectionEnum.d45LeftBack:
        result[widget.carPartDirectionEnum] = d45Frame;
        result[CarPartDirectionEnum.leftBack] = straightFrame;
        break;
      case CarPartDirectionEnum.rightFront:
        result[widget.carPartDirectionEnum] = straightFrame;
        result[CarPartDirectionEnum.d45RightFront] = d45Frame;
        break;
      case CarPartDirectionEnum.leftFront:
        result[widget.carPartDirectionEnum] = straightFrame;
        result[CarPartDirectionEnum.d45LeftFront] = d45Frame;
        break;
      case CarPartDirectionEnum.rightBack:
        result[widget.carPartDirectionEnum] = straightFrame;
        result[CarPartDirectionEnum.d45RightBack] = d45Frame;
        break;
      case CarPartDirectionEnum.leftBack:
        result[widget.carPartDirectionEnum] = straightFrame;
        result[CarPartDirectionEnum.d45LeftBack] = d45Frame;
        break;
      // case CarPartDirectionEnum.left:
      //   break;
      case CarPartDirectionEnum.leftDev:
        break;
      case CarPartDirectionEnum.leftProd:
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.rangeShot == LocaleKeys.longShot.trans)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    showDropDown = !showDropDown;
                  });
                },
                child: Container(
                  key: dropDownKey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        anglesShot[currentAngle] ?? '',
                        style: CTextStyles.baseWhite.s14.w500(),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              if (showDropDown) _frameSelector(),
            ],
          ),
        if (widget.rangeShot != LocaleKeys.longShot.trans) const SizedBox(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.rangeShot,
            style: CTextStyles.baseWhite.s14.w500(),
          ),
        ),
      ],
    );
  }

  Widget _frameSelector() {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: anglesShot.keys.map((e) {
          return Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                anglesShot[e] ?? '',
                style: CTextStyles.baseWhite.s14.w500(),
              ),
              activeColor: Colors.white,
              value: e,
              selected: currentAngle == e,
              groupValue: currentAngle,
              onChanged: (value) async {
                setState(() {
                  currentAngle = e;
                  widget.onAngleCallBack?.call(currentAngle);
                  showDropDown = false;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
