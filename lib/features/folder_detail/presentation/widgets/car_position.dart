// ignore_for_file: deprecated_member_use_from_same_package

import 'package:aicycle_claimme_lib/features/direction_detail.dart/presentation/direction_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../aicycle_claimme_lib.dart';
import '../../../../common/themes/c_colors.dart';
import '../../../../common/themes/c_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../enum/car_model.dart';
import '../../../../enum/car_part_direction.dart';
import '../../../../generated/assets.gen.dart';
import '../../../camera/presentation/camera_page.dart';
import '../../data/models/image_direction_model.dart';

class CarPosition extends StatelessWidget {
  final String claimFolderId;
  final CarPartDirectionEnum direction;
  final ImageDirectionModel? imageDirectionModel;
  const CarPosition({
    super.key,
    required this.direction,
    required this.claimFolderId,
    this.imageDirectionModel,
  });

  @override
  Widget build(BuildContext context) {
    // final scrWidth = MediaQuery.of(context).size.width;
    final String? image = imageDirectionModel?.thumbnail;
    return InkWell(
      onTap: () {
        if (image == null || imageDirectionModel?.totalImage == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CameraPage(
                argument: ClaimMeCameraArgument(
                  carPartDirectionEnum: direction,
                  carModelEnum: CarModelEnum.kiaMorning,
                  claimId: claimFolderId,
                ),
              ),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DirectionDetailPage(
                argument: ClaimMeCameraArgument(
                  carPartDirectionEnum: direction,
                  carModelEnum: CarModelEnum.kiaMorning,
                  claimId: claimFolderId,
                ),
              ),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              image: imageDirectionModel?.thumbnail == null
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(
                        imageDirectionModel!.thumbnail!,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            child: imageDirectionModel == null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Assets.icons.icCamera.svg(
                      color: CColors.primaryA500,
                      package: packageName,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black.withOpacity(0.85),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icons.icPhoto.svg(package: packageName),
                              const Gap(4),
                              Text(
                                (imageDirectionModel?.totalImage ?? 0)
                                    .toString(),
                                style: CTextStyles.base.whiteColor.s12.w500(),
                              ),
                            ],
                          ),
                        ),
                        const Gap(6),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icons.icAdd.svg(
                                color: CColors.primaryA500,
                                package: packageName,
                              ),
                              const Gap(4),
                              Assets.icons.icCamera.svg(
                                color: CColors.primaryA500,
                                package: packageName,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const Gap(8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              direction.title,
              textAlign: TextAlign.center,
              style: CTextStyles.base.s12.setColor(CColors.inkA500),
            ),
          ),
        ],
      ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     image == null
      //         ? Container(
      //             padding: const EdgeInsets.all(12),
      //             width: 48,
      //             height: 48,
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(8),
      //             ),
      //             child: Assets.icons.icCamera.svg(
      //               color: CColors.primaryA500,
      //               package: packageName,
      //             ),
      //           )
      //         : CachedImageWidget(
      //             url: image,
      //             width: 40,
      //             height: 40,
      //             borderRadius: 4,
      //           ),
      //     const Gap(10),
      //     Container(
      //       width: (0.8 * scrWidth) / 3,
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(4),
      //       ),
      //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      //       child: Text(
      //         direction.title,
      //         textAlign: TextAlign.center,
      //         style: CTextStyles.base.s12.setColor(CColors.inkA500),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
