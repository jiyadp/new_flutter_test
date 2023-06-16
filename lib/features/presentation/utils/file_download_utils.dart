import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eminencetel/main.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloadUtils {
  Future<String> openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return "";
    final result = await OpenFile.open(file.path);
    return result.message;

    // OpenFile.open(file.path).
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      logger.d("Cannot get download folder path -$err");
    }
    return directory?.path;
  }

  Future<File?> downloadFile(String url, String name) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final appStorage = await getDownloadPath();
      final file = File('$appStorage/$name');
      try {
        final response = await Dio().get(url,
            options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0,
            ));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        return file;
      } catch (e) {
        return file;
      }
    } else {
      Permission.manageExternalStorage.request();
    }
    return null;
  }
}
