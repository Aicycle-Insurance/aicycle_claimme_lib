import 'package:aicycle_claimme_lib/aicycle_claimme_lib.dart';
import 'package:aicycle_claimme_lib/features/camera/data/models/car_part_has_damage_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/extension/translation_ext.dart';
import '../../../../enum/car_model.dart';
import '../../../../enum/car_part_direction.dart';
import '../../../../generated/locales.g.dart';
import 'direction_info_layer.dart';

class GuideFrame extends StatelessWidget {
  const GuideFrame({
    super.key,
    required this.carPartDirectionEnum,
    required this.rangeShot,
    this.showDirectionInfo = true,
    this.carPartsForCloseUpShot = const [],
    this.onPartSelected,
    this.currentPartSeleted,
    this.carModel,
  });
  final CarPartDirectionEnum carPartDirectionEnum;
  final String rangeShot;
  final bool showDirectionInfo;
  final CarModelEnum? carModel;

  ///
  final List<CarPartHasDamageModel> carPartsForCloseUpShot;
  final Function(CarPartHasDamageModel value)? onPartSelected;
  final CarPartHasDamageModel? currentPartSeleted;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var currentDirection = Rx<CarPartDirectionEnum>(carPartDirectionEnum);
    var scaleImageValue = RxDouble(1.0);
    return RotatedBox(
      quarterTurns: 1,
      child: Stack(
        children: [
          if (rangeShot == LocaleKeys.longShot.trans && carModel != null) ...[
            Center(
              child: Obx(
                () => Transform.scale(
                  scale: scaleImageValue.value,
                  child: Image.asset(
                    carModel!.imagePath(currentDirection.value),
                    fit: BoxFit.cover,
                    package: packageName,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            if (carModel != CarModelEnum.truck)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RotatedBox(
                    quarterTurns: 0,
                    child: SizedBox(
                      height: 32,
                      width: screenWidth / 2,
                      child: Obx(
                        () => Slider.adaptive(
                          min: 0.5,
                          max: 1,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white38,
                          value: scaleImageValue.value,
                          onChanged: scaleImageValue.call,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
          if (showDirectionInfo)
            Positioned(
              top: 16,
              left: 16,
              right: 96,
              child: DirectionInfoLayer(
                rangeShot: rangeShot,
                carPartDirectionEnum: carPartDirectionEnum,
                onAngleCallBack: currentDirection,
                carPartHasDamage: carPartsForCloseUpShot,
                onPartSelected: onPartSelected,
                currentPartSeleted: currentPartSeleted,
              ),
            ),
        ],
      ),
    );
  }
}
