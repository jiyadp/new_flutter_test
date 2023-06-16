import 'package:cached_network_image/cached_network_image.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/app_arguments.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({Key? key}) : super(key: key);
  static const String id = 'photo_gallery_screen';

  @override
  Widget build(BuildContext context) {
    PhotosGalleryParams params =
        ModalRoute.of(context)!.settings.arguments as PhotosGalleryParams;
    String imageUrl = params.images?[params.position ?? 0] ?? "";
    String imageName = Uri.parse(imageUrl).path.split("/").last;
    return Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: Text(imageName),
        ),
        body: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              size: 40,
              color: Colors.white,
            ),
            imageBuilder: (context, imageProvider) {
              return PhotoView(
                imageProvider: imageProvider,
                minScale: PhotoViewComputedScale.contained,
              );
            },
          ),
        ));
  }
}
