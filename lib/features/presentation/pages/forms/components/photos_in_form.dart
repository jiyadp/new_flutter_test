import 'dart:async';
import 'dart:io';
import 'package:eminencetel/features/presentation/utils/form_number_argument.dart';
import 'package:image/image.dart' as img;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/domain/entities/photos_response.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_photos_tab_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/photos_upload_cubit.dart';
import 'package:eminencetel/features/presentation/pages/forms/photos/photo_gallery_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/app_arguments.dart';
import 'package:eminencetel/features/presentation/utils/method_utils.dart';
import 'package:eminencetel/features/presentation/utils/watermark_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

class PhotosForm extends StatefulWidget {
  final PhotosSelectionDataResponse? photosSelectionDataResponse;
  final FormNumberArgument? formNumberArgument;

  const PhotosForm(
      {Key? key, this.photosSelectionDataResponse, this.formNumberArgument})
      : super(key: key);

  @override
  State<PhotosForm> createState() => _PhotosFormState();
}

class _PhotosFormState extends State<PhotosForm> {
  late dynamic image;
  late List<int> imgBytes1;
  late List<int> imgBytes2;
  late List<int> watermarkedImgBytes;
  late dynamic decodedOriginalImage;
  late dynamic temporaryReadAsBytes;

  final ImagePicker _picker = ImagePicker();

  var photoUploadCubit = getIt<PhotosUploadCubit>();

  final DynamicPhotosTabCubit dynamicPhotosTabCubit =
      getIt<DynamicPhotosTabCubit>();

  _imgFromCamera(PhotosSelectionDataResponse? photosSelectionDataResponse,
      int position) async {
    image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 95);

    if (image != null) {
      photoUploadCubit.showProgress();

      var siteName = widget.formNumberArgument?.siteName ?? "No Site Name";
      var updatedSiteName =
          siteName.replaceAll(RegExp(r"\s+"), "_").replaceAll("/", "_");
      Directory? directory = Directory(
          '/storage/emulated/0/Pictures/Eminencetel/$updatedSiteName');
      if (!await directory.exists()) {
        directory = await directory.create(recursive: true);
      }
      var imageSize = photosSelectionDataResponse?.images.length ?? 0;
      var imageName =
          "${photosSelectionDataResponse?.photoTitle?.replaceAll(RegExp(r"\s+"), "_")}_${imageSize + 1}";
      logger.d("image name from camera picker $imageName");
      File tempFile = File("${directory.path}/$imageName.jpg");

      if (await tempFile.exists()) {
        var cameraImage =
            await tempFile.writeAsBytes(File(directory.path).readAsBytesSync());
        uploadWaterMarkedImage(cameraImage);
      }
    } else {
      print("File does not exist at the specified path");
    }
  }

  _imgFromGallery(PhotosSelectionDataResponse? photosSelectionDataResponse,
      int position) async {
    // Save Local Form data
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
        requestFullMetadata: false);
    if (image != null) {
      photoUploadCubit.showProgress();
      var siteName = widget.formNumberArgument?.siteName ?? "No Site Name";
      var updatedSiteName =
          siteName.replaceAll(RegExp(r"\s+"), "_").replaceAll("/", "_");
      Directory? directory = Directory(
          '/storage/emulated/0/Pictures/Eminencetel/$updatedSiteName');
      if (!await directory.exists()) {
        directory = await directory.create(recursive: true);
      }
      var imageSize = photosSelectionDataResponse?.images.length ?? 0;
      var imageName =
          "${photosSelectionDataResponse?.photoTitle?.replaceAll(RegExp(r"\s+"), "_")}_${imageSize + 1}";
      File tempFile = File("${directory.path}/$imageName.jpg");
      var galleryImage =
          await tempFile.writeAsBytes(File(image.path).readAsBytesSync());

      uploadWaterMarkedImage(galleryImage);

      // temporaryReadAsBytes = await galleryImage.readAsBytes();
      // imgBytes1 = Uint8List.fromList(temporaryReadAsBytes);
      // addWaterMark(photosSelectionDataResponse);
    }
  }

  void addWaterMark(
      PhotosSelectionDataResponse? photosSelectionDataResponse) async {
    var siteName = widget.formNumberArgument?.siteName ?? "No Site Name";
    var updatedSiteName =
        siteName.replaceAll(RegExp(r"\s+"), "_").replaceAll("/", "_");
    Directory? directory =
        Directory('/storage/emulated/0/Pictures/Eminencetel/$updatedSiteName');
    if (!await directory.exists()) {
      directory = await directory.create(recursive: true);
    }

    logger.d("directory path = ${directory.path}");
    ByteData fBitMapFontData =
        await rootBundle.load("assets/font/roboto.ttf.zip");
    final robotoFont =
        img.BitmapFont.fromZip(fBitMapFontData.buffer.asUint8List());

    // add logo
    var u = await MethodUtils().getImageByteFromAssets();
    imgBytes2 = Uint8List.fromList(u);
    decodedOriginalImage = await decodeImageFromList(temporaryReadAsBytes);
    var logoOriginalImage =
        await decodeImageFromList(Uint8List.fromList(imgBytes2));
    const double scalingFactor = 0.8; // adjust the scaling factor as needed
    final newLogoWidth = (decodedOriginalImage.width * scalingFactor).toInt();
    final newLogoHeight =
        (newLogoWidth * logoOriginalImage.height / logoOriginalImage.width)
            .toInt();

    logger.d(
        "original Image size = ${decodedOriginalImage.width} X ${decodedOriginalImage.height}");
    logger.d(
        "logoOriginal Image size = ${logoOriginalImage.width} X ${logoOriginalImage.height}");

    var siteId = widget.formNumberArgument?.siteId ?? "";
    var latitude = widget.formNumberArgument?.latitude ?? "";
    var longitude = widget.formNumberArgument?.longitude ?? "";
    var dateTime = DateTime.now();

    var waterMarkMessage = "$siteName\n${"$latitude,$longitude"}\n$dateTime";
    // Binding watermark to the original image
    logger.d("loading watermark image");
    // disabling for now for improving performance
    var updatedWaterMarkedImage =
        await compute(WaterMarkUtils.addWaterMarksLogo, {
      'originalImageBytes': imgBytes1,
      'watermarkImageBytes': imgBytes2,
      'imgHeight': newLogoHeight,
      'imgWidth': newLogoWidth,
      'dstX': decodedOriginalImage.width - 650,
      'dstY': decodedOriginalImage.height - 280,
    });
    var completedWaterMarkImage =
        await compute(WaterMarkUtils.addWaterMarksText, {
      'originalImageBytes': updatedWaterMarkedImage,
      'font': robotoFont,
      'watermarkText': waterMarkMessage,
      'dstX': 80,
      'dstY': 0,
      'color': Colors.white
    });

    logger.d("completed watermark image");
    var compressedWaterMarkImage = await FlutterImageCompress.compressWithList(
        completedWaterMarkImage,
        quality: 70);
    logger.d("completed compressed watermark image");
    var imageSize = photosSelectionDataResponse?.images.length ?? 0;
    var imageName =
        "${photosSelectionDataResponse?.photoTitle}_${imageSize + 1}.jpg";
    final myImagePath = "${directory.path}/$imageName";
    var imageFile = await WaterMarkUtils.writeImageToFiles(
        myImagePath, compressedWaterMarkImage);
    if (imageFile != null) {
      uploadWaterMarkedImage(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosUploadCubit>(
        create: (_) => photoUploadCubit,
        child: BlocBuilder<PhotosUploadCubit, DataState<PhotosUploadModel>>(
            builder: (context, state) {
          if (state.isInProgress) {
            return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      Text(
                        "Uploading in progress",
                        style: CustomTextStyles.regular16(CustomColors.black),
                      )
                    ],
                  ),
                ));
          } else {
            if (state.isSuccess) {
              var uploadedImageUrl = state.data?.data ?? "";
              widget.photosSelectionDataResponse?.images.add(uploadedImageUrl);
            }
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: (widget.photosSelectionDataResponse?.images.isNotEmpty ??
                      false)
                  ? MediaQuery.of(context).size.height / 3
                  : MediaQuery.of(context).size.height / 5.1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  color: CustomColors.cardBack,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showPicker(
                                context, widget.photosSelectionDataResponse, 0);
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            borderOnForeground: true,
                            shape: Border.all(
                                color: CustomColors.black, width: 0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.photosSelectionDataResponse
                                              ?.photoTitle ??
                                          "no title",
                                      style: CustomTextStyles.regular16(
                                          CustomColors.black),
                                    ),
                                  ),
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: CustomColors.black,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: (widget.photosSelectionDataResponse?.images
                                      .isNotEmpty ??
                                  false)
                              ? MediaQuery.of(context).size.height / 6
                              : MediaQuery.of(context).size.height / 12,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.photosSelectionDataResponse
                                      ?.images.length ??
                                  0,
                              shrinkWrap: true,
                              itemBuilder: (context, imagePosition) {
                                logger.d(
                                    "image ob ${widget.photosSelectionDataResponse?.images[imagePosition]}");
                                return GestureDetector(
                                  onLongPress: () {
                                    //  if (editDisabled == false) {
                                    deleteBottomSheet(
                                        context,
                                        widget.photosSelectionDataResponse,
                                        imagePosition,
                                        0);
                                    // }
                                  },
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PhotoGalleryScreen.id,
                                        arguments: PhotosGalleryParams(
                                            images: widget
                                                .photosSelectionDataResponse
                                                ?.images,
                                            position: imagePosition));
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: Stack(
                                      children: [
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor:
                                                    const Color(0xFFF5F5F5),
                                                highlightColor:
                                                    const Color(0xFFE0E0E0),
                                                child: ClipRRect(
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              imageUrl: widget
                                                      .photosSelectionDataResponse
                                                      ?.images[imagePosition] ??
                                                  "",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }));
  }

  Future<void> uploadWaterMarkedImage(File imageFile) {
    return Future.delayed(const Duration(seconds: 2),
        () => photoUploadCubit.uploadPhoto(imageId: imageFile));
  }

  void showPicker(context,
      PhotosSelectionDataResponse? photosSelectionDataResponse, int position) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: CustomColors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        _imgFromGallery(photosSelectionDataResponse, position);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera(photosSelectionDataResponse, position);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void deleteBottomSheet(context, PhotosSelectionDataResponse? photoDetails,
      int imagePosition, int photoCardPosition) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
              child: Container(
            color: CustomColors.white,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(
                        LocaleStrings.areYouSure,
                        style: CustomTextStyles.bold18(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        LocaleStrings.doYouWant,
                        style: CustomTextStyles.bold16(CustomColors.black),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CustomButton(
                                buttonColor: CustomColors.lightHash,
                                text: LocaleStrings.cancel,
                                onClick: () {
                                  Navigator.of(context).pop();
                                }),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CustomButton(
                                buttonColor: CustomColors.red,
                                text: LocaleStrings.delete,
                                onClick: () {
                                  photoDetails?.images.removeAt(imagePosition);

                                  var dynamicPhotosData = dynamicPhotosTabCubit
                                      .dynamicPhotosTabLocalDataSourceGetUseCase
                                      .getUserEnteredData();
                                  dynamicPhotosData
                                      .photosTabList?[0]
                                      .photosSelectionList?[photoCardPosition]
                                      ?.images
                                      .removeAt(imagePosition);
                                  dynamicPhotosTabCubit
                                      .dynamicPhotosTabLocalDataSourceSetUseCase
                                      .setUserEnteredData(dynamicPhotosData);
                                  photoUploadCubit.refreshPhoto();
                                  Navigator.of(context).pop();
                                }),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
