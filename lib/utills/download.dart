import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Download{

  static Future<bool> requestFilePermission(String url, {required String filename}) async {
    PermissionStatus result;
    /*AnchorElement anchorElement = AnchorElement(href: "Desktop/$url");
  anchorElement.download = filename;
  anchorElement.click();
  print("object ${anchorElement}");*/
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }
    if (result.isGranted) {
      print("permission for android is granted");
      // downloadPdfFile("http://34.227.86.241:1317/uploads/sendle-print-label/21_10_2022_11_58_45.pdf", filename: "21_10_2022_11_58_45");
      downloadPdfFile(url, filename: filename);
      Utils.showSnackbar("Downloaded");
      return true;
    } else if (Platform.isIOS) {
      result = await Permission.storage.request();
      if (result.isGranted) {
        print("permission for ios is granted");
        // downloadPdfFile("http://34.227.86.241:1317/uploads/sendle-print-label/21_10_2022_11_58_45.pdf", filename: "21_10_2022_11_58_45");
        downloadPdfFile(url, filename: filename);
        Utils.showSnackbar("Downloaded");
        return true;
      }
    } else {
      print("permission is other issue");
    }
    return false;
  }

  static downloadPdfFile(String url, {required String filename}) async {
    var httpClient = http.Client();
    var request = http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);

    List<List<int>> chunks = [];
    int downloaded = 0;

    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength! * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        debugPrint('downloadPercentage inside: ${downloaded / r.contentLength! * 100}');
        //debugPrint('directory inside: ${directoryOfFile.value}');

        // Save the file

        String documentsPath = '/storage/emulated/0/Documents';
        if (Platform.isIOS) {
          Directory path = await getApplicationDocumentsDirectory();
          documentsPath = path.path;
        }
        File file = File('$documentsPath/$filename');
        file.create(recursive: true);
        final Uint8List bytes = Uint8List(r.contentLength!);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);
        file.uri.toString();
      });
    });
  }

}