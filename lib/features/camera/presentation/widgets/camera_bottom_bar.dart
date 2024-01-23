import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/cache_image_widget.dart';
import '../../../../common/themes/c_colors.dart';

class AiCameraBottomBar extends StatelessWidget {
  const AiCameraBottomBar({
    super.key,
    this.previewFile,
    this.flashMode,
    required this.takePhoto,
    required this.toggleFlashMode,
    this.imageNetworkList = const [],
    this.orientation = DeviceOrientation.portraitUp,
  });
  final XFile? previewFile;
  final FlashMode? flashMode;
  final Function() takePhoto;
  final Function()? toggleFlashMode;
  final List imageNetworkList;
  final DeviceOrientation? orientation;

  static const double _bottomBarHeight = 100;
  static const noImage =
      'https://www.oyostatejudiciary.oy.gov.ng/wp-content/uploads/2022/04/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg';

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
    return Container(
      height: _bottomBarHeight,
      color: CColors.transparent,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (previewFile == null) ...[
              CupertinoButton(
                padding: const EdgeInsets.only(left: 16),
                minSize: 0,
                onPressed: toggleFlashMode,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CColors.inkA100,
                    border: Border.all(
                      width: 1,
                      color: CColors.inkA100,
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: AnimatedRotation(
                    turns: rotate,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      flashMode?.name != 'torch'
                          ? Icons.flash_off_rounded
                          : Icons.flash_on_rounded,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              ),
              Center(
                child: CupertinoButton(
                  padding: const EdgeInsets.only(left: 16),
                  minSize: 0,
                  onPressed: takePhoto,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: AnimatedRotation(
                      turns: rotate,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedRotation(
                    turns: rotate,
                    duration: const Duration(milliseconds: 300),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedImageWidget(
                            url: imageNetworkList.isNotEmpty
                                ? imageNetworkList.last.url ??
                                    imageNetworkList.last.imageUrl ??
                                    ''
                                : noImage,
                            height: 52,
                            width: 52,
                            fit: BoxFit.cover,
                            borderRadius: 8,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: Text(
                              imageNetworkList.length.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
