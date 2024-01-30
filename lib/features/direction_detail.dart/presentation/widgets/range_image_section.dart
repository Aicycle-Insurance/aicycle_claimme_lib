import 'package:aicycle_claimme_lib/common/themes/c_textstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/themes/c_colors.dart';
import '../../../../generated/locales.g.dart';
import '../../../../common/extension/translation_ext.dart';
import '../../data/models/claim_image_model.dart';

class RangeImageSection extends StatelessWidget {
  const RangeImageSection({
    super.key,
    required this.rangeId,
    this.images = const [],
    this.onTakePhoto,
    this.isLoading,
    this.onDeleteImage,
    this.deletingList = const [],
  });
  final int rangeId;
  final List<ClaimImageModel> images;
  final Function()? onTakePhoto;
  final Function(String imageId)? onDeleteImage;
  final bool? isLoading;
  final List<String> deletingList;

  String get title {
    switch (rangeId) {
      case 1:
        return LocaleKeys.longShot.trans;
      case 2:
        return LocaleKeys.middleShot.trans;
      case 3:
        return LocaleKeys.closeUpShot.trans;
      default:
        return LocaleKeys.longShot.trans;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title (${images.length})',
              style: CTextStyles.base.blackColor.s16.w600(),
            ),
            if (rangeId != 1)
              CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: onTakePhoto,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.camera,
                        size: 18,
                        color: CColors.primaryA500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        LocaleKeys.addPhoto.trans,
                        style: CTextStyles.base.primaryColor.s14.w600(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const Gap(8),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: isLoading == true
              ? [1, 2]
                  .map((e) => Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.white,
                        child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ))
                  .toList()
              : images.isNotEmpty
                  ? images.map((e) {
                      return ImageContainer(
                        imageUrl: e.url,
                        isDeleting: deletingList.contains(e.imageId),
                        onDelete: () {
                          onDeleteImage?.call(e.imageId ?? '');
                        },
                        onRetake: () {},
                        // onRetake: () => _pushToCamera(
                        //   rangeId: rangeId,
                        //   oldImageId: int.tryParse(e.imageId.toString()),
                        // ),
                      );
                    }).toList()
                  : [
                      ImageContainer(
                        onRetake: onTakePhoto,
                      ),
                    ],
        ),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    this.imageUrl,
    this.onRetake,
    this.onDelete,
    this.isDeleting = false,
    this.hideRetake = false,
  });

  final String? imageUrl;
  final Function()? onRetake;
  final Function()? onDelete;
  final bool isDeleting;
  final bool hideRetake;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return InkWell(
        onTap: onRetake,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CColors.primaryA500,
              width: 2,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.camera_alt_outlined,
              size: 36,
              color: CColors.primaryA500,
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        image: !isDeleting
            ? DecorationImage(
                image: CachedNetworkImageProvider(imageUrl!, scale: 1),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isDeleting
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(),
                  const SizedBox(height: 8),
                  Text(LocaleKeys.isDeleting.trans),
                ],
              ),
            )
          : Stack(
              children: [
                Positioned(
                  right: 8,
                  top: 8,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: const Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (!hideRetake)
                        GestureDetector(
                          onTap: onRetake,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
