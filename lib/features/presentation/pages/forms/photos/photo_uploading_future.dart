import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/entities/photos_response.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_photos_tab_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/photos_upload_cubit.dart';
import 'package:eminencetel/features/presentation/pages/forms/photos/photo_gallery_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/app_arguments.dart';
import 'package:eminencetel/features/presentation/utils/form_number_argument.dart';
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
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:image/image.dart' as img;

class PhotoUploadingFuture extends StatefulWidget {
  final int tabPosition;
  final FormNumberArgument? formNumberArgument;

  const PhotoUploadingFuture({Key? key, required this.tabPosition,required this.formNumberArgument}) : super(key: key);

  @override
  State<PhotoUploadingFuture> createState() => _PhotoUploadingFutureState();
}

class _PhotoUploadingFutureState extends State<PhotoUploadingFuture> {
  var imgBytes1;

  var imgBytes2;

  var watermarkedImgBytes;

  var decodedOriginalImage;

  var temporaryReadAsBytes;

  final ImagePicker _picker = ImagePicker();

  var photoUploadCubit = getIt<PhotosUploadCubit>();

  final DynamicPhotosTabCubit dynamicPhotosTabCubit =
      getIt<DynamicPhotosTabCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosUploadCubit>(
        create: (_) => photoUploadCubit,
        child: BlocBuilder<PhotosUploadCubit, DataState<PhotosUploadModel>>(
            builder: (context, state) {
          var photosSelectionDataResponse = dynamicPhotosTabCubit
              .getLocalDynamicPhotosTabData()
              .photosTabList?[widget.tabPosition]
              .photosSelectionList;
          if (state.isInProgress) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      Text(
                        "Please wait ",
                        style: CustomTextStyles.regular16(CustomColors.black),
                      )
                    ],
                  ),
                ));
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                  itemCount: photosSelectionDataResponse?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, photoCardPosition) {
                    // var imageUrl = state.data?.data;
                    var photoDetails = photosSelectionDataResponse?[photoCardPosition];
                    //photoDetails?.images.add(imageUrl);
                    String? title = photoDetails?.photoTitle ?? "";
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        color: CustomColors.cardBack,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // if (editDisabled == false) {
                                  showPicker(
                                      context,
                                      photoDetails,
                                      photoCardPosition);
                                  //    }
                                },
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  borderOnForeground: true,
                                  shape: Border.all(
                                      color: CustomColors.black, width: 0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title,
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
                                height: 30,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 6,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: photoDetails?.images.length ?? 0,
                                    shrinkWrap: true,
                                    itemBuilder: (context, imagePosition) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          //  if (editDisabled == false) {
                                          deleteBottomSheet(
                                              context,
                                              photoDetails,
                                              imagePosition,
                                              photoCardPosition);
                                          // }
                                        },
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, PhotoGalleryScreen.id,
                                              arguments: PhotosGalleryParams(
                                                  images: photoDetails?.images,
                                                  position: imagePosition));
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: Stack(
                                            children: [
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    errorWidget: (context, url,
                                                            error) {
                                                      logger.e(error.toString());
                                                          return const Icon(Icons.error);
                                                        },
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor: const Color(
                                                          0xFFF5F5F5),
                                                      highlightColor:
                                                          const Color(
                                                              0xFFE0E0E0),
                                                      child: ClipRRect(
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                    imageUrl: photoDetails
                                                                ?.images[
                                                            imagePosition] ??
                                                        "",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
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
                    );
                  }),
            );
          }
        }));
  }

  getCurrentDate() {
    return DateFormat('dd-MM-yyyy HH:mm:ss a').format(DateTime.now());
  }

  _imgFromCamera(PhotosSelectionDataResponse? photosSelectionDataResponse, int position) async {
    // Save Local data
    var dynamicPhotosData = dynamicPhotosTabCubit.dynamicPhotosTabLocalDataSourceGetUseCase.getUserEnteredData();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 95);
    if (image != null) {
      photoUploadCubit.showProgress();

      var updatedSiteName = widget.formNumberArgument?.siteName.replaceAll(" ", "_").replaceAll("/", "_");
      Directory? directory = Directory('/storage/emulated/0/Pictures/Eminencetel/$updatedSiteName');
      if (!await directory.exists()) {
        directory = await directory.create(recursive: true);
      }
      var imageSize = photosSelectionDataResponse?.images.length ?? 0;
      var imageName = "${photosSelectionDataResponse?.photoTitle?.replaceAll(" ", "_")}_${imageSize + 1}";
      File tempFile = File("${directory.path}/$imageName.jpg");
      var cameraImage = await tempFile.writeAsBytes(File(image.path).readAsBytesSync());

      uploadWaterMarkedImage(cameraImage, dynamicPhotosData, position);
      //
      // temporaryReadAsBytes = await cameraImage.readAsBytes();
      // imgBytes1 = Uint8List.fromList(temporaryReadAsBytes);
      //
      // addWaterMarkForImage(image,photosSelectionDataResponse,dynamicPhotosData,position);
    }
  }

  _imgFromGallery(PhotosSelectionDataResponse? photosSelectionDataResponse, int position) async {
    // Save Local data
    var dynamicPhotosData = dynamicPhotosTabCubit.dynamicPhotosTabLocalDataSourceGetUseCase.getUserEnteredData();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 95);
    if (image != null) {
      photoUploadCubit.showProgress();
      var updatedSiteName = widget.formNumberArgument?.siteName.replaceAll(" ", "_").replaceAll("/", "_");
      Directory? directory = Directory('/storage/emulated/0/Pictures/Eminencetel/$updatedSiteName');
      if (!await directory.exists()) {
        directory = await directory.create(recursive: true);
      }
      var imageSize = photosSelectionDataResponse?.images.length ?? 0;
      var imageName = "${photosSelectionDataResponse?.photoTitle?.replaceAll(" ", "_")}_${imageSize+1}";
      File tempFile = File("${directory.path}/$imageName.jpg");
      var galleryImage = await tempFile.writeAsBytes(File(image.path).readAsBytesSync());

      uploadWaterMarkedImage(galleryImage, dynamicPhotosData, position);

      // temporaryReadAsBytes = await galleryImage.readAsBytes();
      // imgBytes1 = Uint8List.fromList(temporaryReadAsBytes);
      // addWaterMarkForImage(image,photosSelectionDataResponse,dynamicPhotosData,position);
    }
  }

   addWaterMarkForImage(XFile? image,PhotosSelectionDataResponse? photosSelectionDataResponse, CategoriesData dynamicPhotosData, int position) async {

     var updatedSiteName = widget.formNumberArgument?.siteName.replaceAll(" ", "_").replaceAll("/", "_");
     Directory? directory = Directory('/storage/emulated/0/Pictures/Eminencetel/$updatedSiteName/WaterMarked');
     if (!await directory.exists()) {
       directory = await directory.create(recursive: true);
     }

     logger.d("directory path = ${directory.path}");
     ByteData fBitMapFontData = await rootBundle.load("assets/font/roboto.ttf.zip");
     final robotoFont = img.BitmapFont.fromZip(fBitMapFontData.buffer.asUint8List());

     // add logo
     var u = await MethodUtils().getImageByteFromAssets();
     imgBytes2 = Uint8List.fromList(u);
     decodedOriginalImage = await decodeImageFromList(temporaryReadAsBytes);
     var logoOriginalImage = await decodeImageFromList(imgBytes2);
     const double scalingFactor = 0.8; // adjust the scaling factor as needed
     final newLogoWidth = (decodedOriginalImage.width * scalingFactor).toInt();
     final newLogoHeight = (newLogoWidth * logoOriginalImage.height / logoOriginalImage.width).toInt();


     logger.d("original Image size = ${decodedOriginalImage.width} X ${decodedOriginalImage.height}");
     logger.d("logoOriginal Image size = ${logoOriginalImage.width} X ${logoOriginalImage.height}");

     var siteName = widget.formNumberArgument?.siteName ?? "";
     var siteId = widget.formNumberArgument?.siteId ?? "";
     var latitude = widget.formNumberArgument?.latitude ?? "";
     var longitude = widget.formNumberArgument?.longitude ?? "";
     var dateTime = DateTime.now();


     var waterMarkMessage = "$siteName\n${"$latitude,$longitude"}\n$dateTime";
     // Binding watermark to the original image
     logger.d("loading watermark image");
     var updatedWaterMarkedImage = await compute(WaterMarkUtils.addWaterMarksLogo,{
       'originalImageBytes': imgBytes1,
       'watermarkImageBytes': imgBytes2,
       'imgHeight': newLogoHeight,
       'imgWidth': newLogoWidth,
       'dstX': decodedOriginalImage.width - 650,
       'dstY': decodedOriginalImage.height - 280,
     });
     var completedWaterMarkImage = await compute(WaterMarkUtils.addWaterMarksText,{
       'originalImageBytes': updatedWaterMarkedImage,
       'font': robotoFont,
       'watermarkText': waterMarkMessage,
       'dstX': 80,
       'dstY': 0,
       'color':Colors.white
     });
     logger.d("completed watermark image");
     var compressedWaterMarkImage = await FlutterImageCompress.compressWithList(completedWaterMarkImage,quality: 70);
     logger.d("completed compressed watermark image");
     var imageSize = photosSelectionDataResponse?.images.length ?? 0;
     var imageName = "${photosSelectionDataResponse?.photoTitle}_${imageSize+1}.jpg";
     final myImagePath = "${directory.path}/$imageName";
     var imageFile = await WaterMarkUtils.writeImageToFiles(myImagePath, compressedWaterMarkImage);
    if (imageFile != null) {
      uploadWaterMarkedImage(imageFile, dynamicPhotosData, position);
    }
  }

  Future<void> uploadWaterMarkedImage(File imageFile, CategoriesData dynamicPhotosData, int position) {
    return Future.delayed(const Duration(seconds: 2), () =>
        photoUploadCubit.uploadPhotos(
            imageId: imageFile,
            imagesList: dynamicPhotosData,
            tabPosition: widget.tabPosition,
            imagePosition: position)
    );
  }

  void showPicker(context, PhotosSelectionDataResponse? photosSelectionDataResponse, int position) {
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

  void deleteBottomSheet(
    context,
    PhotosSelectionDataResponse? photoDetails,
    int imagePosition,
    int photoCardPosition,
  ) {
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
                                      .photosTabList?[widget.tabPosition]
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
