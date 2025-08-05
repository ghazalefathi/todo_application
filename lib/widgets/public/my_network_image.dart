import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/widgets/public/custom_shimmer.dart';
import '../../core/api_provider.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage(
      {required this.imageAddress,
      this.borderRadius,
      this.height,
      this.width,
      this.boxFit,
      this.bgColor,
      this.hasNoImageAsset,
      this.onError,
      this.onSuccess,
      super.key});

  final String? imageAddress;
  final Widget? hasNoImageAsset;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? boxFit;
  final Color? bgColor;
  final Function()? onError;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        width: width,
        height: height,
        color: bgColor,
        child: imageAddress == '' || imageAddress == null
            ? hasNoImageAsset ?? CustomShimmerWidget()
            : CachedNetworkImage(
                alignment: Alignment.center,
                imageUrl: ApiProvider.getImageUrl(imageAddress),
                fit: boxFit ?? BoxFit.contain,
                width: width,
                height: height,
                placeholder: (context, url) => CustomShimmerWidget(
                  margin: EdgeInsets.zero,
                ),
                httpHeaders: {
                  'Access-Control-Allow-Origin': '*',
                  'Access-Control-Allow-Headers': 'Accept'
                },
                imageBuilder: (context, imageProvider) {
                  if (onSuccess != null) {
                    onSuccess!();
                  }
                  return CachedNetworkImage(
                    alignment: Alignment.center,
                    imageUrl: ApiProvider.getImageUrl(imageAddress),
                    fit: boxFit ?? BoxFit.contain,
                    width: width,
                    height: height,
                  );
                },
                errorWidget: (context, url, error) {
                  if (onError != null) {
                    onError!();
                  }
                  return hasNoImageAsset ?? CustomShimmerWidget(margin: EdgeInsets.zero);
                },
              ),
      ),
    );
  }
}
