import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {

  final String url;
  final double height;
  final double width;
  final BoxFit fit;
  final double borderRadius;

  const CustomImage({Key? key, required this.height, required this.width, required this.url,this.fit=BoxFit.contain, this.borderRadius=5}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        errorWidget: (context, url, error) {
          return SizedBox(
            height: height,width: width,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.2),
              child: Container(
                color: Colors.white,
              ),
            ),
          );

        },
        placeholder: (context,url)=>SizedBox(
          height: height,width: width,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.3),
            highlightColor: Colors.grey.withOpacity(0.2),
              child: Container(
                color: Colors.white,
              )
          ),
        ),
        height: height,width: width,
      ),
    );
  }
}
