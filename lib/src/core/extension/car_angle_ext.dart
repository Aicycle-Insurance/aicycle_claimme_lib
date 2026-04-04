import '../../../aicycle_claimme_plus.dart';
import '../theme/app_strings.dart';

extension CarAngleExt on AicycleCarAngle {
  String get id {
    switch (this) {
      case AicycleCarAngle.front:
        return 'truoc-sT9qgX';
      case AicycleCarAngle.frontLeft:
        return '45-trai-truoc-C1xM02';
      case AicycleCarAngle.frontRight:
        return '45-phai-truoc-UoYzs6';
      case AicycleCarAngle.rear:
        return 'sau-htBwjB';
      case AicycleCarAngle.rearLeft:
        return '45-trai-sau-1q3G3J';
      case AicycleCarAngle.rearRight:
        return '45-phai-sau-fRzY3r';
      // case AicycleCarAngle.left:
      //   return 'trai-MyuVUE';
      // case AicycleCarAngle.right:
      //   return 'phai-4wif2Z';
      case AicycleCarAngle.regCert:
        return 'dang-kiem-xe-82YjAa';
      case AicycleCarAngle.exterior:
        return '45-trai-truoc-C1xM02';
    }
  }

  //  up(1, 'tren-BrogFf'),
  //   front(2, 'truoc-sT9qgX'),
  //   d45RightFront(3, '45-phai-truoc-UoYzs6'),
  //   d45LeftFront(4, '45-trai-truoc-C1xM02'),
  //   back(5, 'sau-htBwjB'),
  //   d45RightBack(6, '45-phai-sau-fRzY3r'),
  //   d45LeftBack(7, '45-trai-sau-1q3G3J'),
  //   rightFront(8, 'phai-truoc-eYWg1d'),
  //   leftFront(9, 'trai-truoc-r6BEZd'),
  //   rightBack(10, 'phai-sau-v1hAm6'),
  //   leftBack(11, 'trai-sau-t8QgFO'),

  //   /// Góc trái trên môi trường dev có id là 31
  //   leftDev(31, 'trai-MyuVUE'),

  //   /// Góc trái trên môi trường production có id là 22
  //   leftProd(22, 'trai-MyuVUE');
  List<int> get numberId {
    switch (this) {
      case AicycleCarAngle.front:
        return [2];
      case AicycleCarAngle.frontLeft:
        return [4, 9];
      case AicycleCarAngle.frontRight:
        return [3, 8];
      case AicycleCarAngle.rear:
        return [5];
      case AicycleCarAngle.rearLeft:
        return [7, 11];
      case AicycleCarAngle.rearRight:
        return [6, 10];
      case AicycleCarAngle.regCert:
        return [0];
      case AicycleCarAngle.exterior:
        return [2, 3, 4, 9, 8, 5, 7, 11, 6, 10];
    }
  }

  String get title {
    final config = AicycleClaimMe.config;
    final displayName =
        config.displayConfig.carAnglesWithDisplayName[this] ??
        AppStrings.noDisplayName;
    return displayName;
  }

  String get description {
    switch (this) {
      case AicycleCarAngle.front:
        return AppStrings.frontCaptureDescription;
      case AicycleCarAngle.frontLeft:
        return AppStrings.frontLeftCaptureDescription;
      case AicycleCarAngle.frontRight:
        return AppStrings.frontRightCaptureDescription;
      case AicycleCarAngle.rear:
        return AppStrings.rearCaptureDescription;
      case AicycleCarAngle.rearLeft:
        return AppStrings.rearLeftCaptureDescription;
      case AicycleCarAngle.rearRight:
        return AppStrings.rearRightCaptureDescription;
      // case AicycleCarAngle.left:
      //   return AppStrings.leftCaptureDescription;
      // case AicycleCarAngle.right:
      //   return AppStrings.rightCaptureDescription;
      default:
        return '';
    }
  }

  // List<String> get sampleImages {
  //   switch (this) {
  //     case AicycleCarAngle.front:
  //       return [Assets.images.front.imgFront.path];
  //     case AicycleCarAngle.frontLeft:
  //       return [
  //         Assets.images.frontLeft.imgFrontLeft1.path,
  //         Assets.images.frontLeft.imgFrontLeft2.path,
  //         Assets.images.frontLeft.imgFrontLeft3.path,
  //         Assets.images.frontLeft.imgFrontLeft4.path,
  //       ];
  //     case AicycleCarAngle.frontRight:
  //       return [
  //         Assets.images.frontRight.imgFrontRight1.path,
  //         Assets.images.frontRight.imgFrontRight2.path,
  //         Assets.images.frontRight.imgFrontRight3.path,
  //         Assets.images.frontRight.imgFrontRight4.path,
  //       ];
  //     case AicycleCarAngle.rear:
  //       return [Assets.images.rear.imgRear.path];
  //     case AicycleCarAngle.rearLeft:
  //       return [
  //         Assets.images.rearLeft.imgRearLeft1.path,
  //         Assets.images.rearLeft.imgRearLeft2.path,
  //         Assets.images.rearLeft.imgRearLeft3.path,
  //       ];
  //     case AicycleCarAngle.rearRight:
  //       return [
  //         Assets.images.rearRight.imgRearRight1.path,
  //         Assets.images.rearRight.imgRearRight2.path,
  //         Assets.images.rearRight.imgRearRight3.path,
  //       ];
  //     case AicycleCarAngle.left:
  //       return [Assets.images.left.imgLeft.path];
  //     case AicycleCarAngle.right:
  //       return [Assets.images.right.imgRight.path];
  //     default:
  //       return [];
  //   }
  // }
}
