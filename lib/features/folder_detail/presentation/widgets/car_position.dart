// ignore_for_file: deprecated_member_use_from_same_package

import '../../../../aicycle_claimme_lib.dart';
import '../../../../common/cache_image_widget.dart';
import '../../../../common/themes/c_colors.dart';
import '../../../../common/themes/c_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../enum/car_part_direction.dart';
import '../../../../generated/assets.gen.dart';
import '../../data/models/image_direction_model.dart';

class CarPosition extends StatelessWidget {
  final String claimFolderId;
  final CarPartDirectionEnum direction;
  final List<ImageDirectionModel>? imageDirectionModels;
  const CarPosition({
    super.key,
    required this.direction,
    required this.claimFolderId,
    this.imageDirectionModels,
  });

  @override
  Widget build(BuildContext context) {
    final scrWidth = MediaQuery.of(context).size.width;
    final String? image = imageDirectionModels
        ?.firstWhere(
          (e) =>
              e.directionSlug == direction.excelId.toString() ||
              e.directionId.toString() == direction.id.toString(),
          orElse: () => const ImageDirectionModel(),
        )
        .thumbnail;

    return InkWell(
      onTap: () {},
      // onTap: () => Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => CameraPage(
      //       argument: BuyMeCameraArgument(
      //         carPartDirectionEnum: direction,
      //         carModelEnum: CarModelEnum.kiaMorning,
      //         claimId: claimFolderId,
      //       ),
      //     ),
      //   ),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image == null
              ? Container(
                  padding: const EdgeInsets.all(12),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Assets.icons.icCamera.svg(
                    color: CColors.primaryA500,
                    package: packageName,
                  ),
                )
              : CachedImageWidget(
                  url: image,
                  width: 40,
                  height: 40,
                  borderRadius: 4,
                ),
          const Gap(10),
          Container(
            width: (0.8 * scrWidth) / 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              direction.title,
              textAlign: TextAlign.center,
              style: CTextStyles.base.s12.setColor(CColors.inkA500),
            ),
          ),
        ],
      ),
    );
  }
}
