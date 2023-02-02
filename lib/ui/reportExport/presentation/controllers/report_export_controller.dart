import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/reportExport/domain/report_export_use_case.dart';
import 'package:jumppoint_app/utills/download.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:universal_html/html.dart';

class ReportExportController extends SuperController {
  final ProgressController progressController;
  final ReportExportUseCase reportExportUseCase;
  final SharedPreferenceController sharedPreferenceController;

  ReportExportController(this.progressController, this.reportExportUseCase,
      this.sharedPreferenceController);

  final TextEditingController editConFrom = TextEditingController();
  final TextEditingController editConTo = TextEditingController();

  final FocusNode focusFrom = FocusNode();
  final FocusNode focusTo = FocusNode();

  final RxBool fromStr = false.obs;
  final RxBool toStr = false.obs;

  final RxString shipmentRecord = "".obs;
  final RxString balanceRecord = "".obs;

  RxInt currentType = 0.obs;
  RxBool isSelectSenderFilled = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() async {
    // TODO: implement onResumed
  }

  void getExportShipmentRecord(bool isWeb) {
    reportExportUseCase.getExportShipmentRecord(editConFrom.text.trim(),editConTo.text.trim()).then((value) {
      if (value != null) {
        print("getExportShipmentRecord---------${value.result}");
        shipmentRecord.value = value.result['url'];
        print("shipmentRecord.value===>>> ${shipmentRecord.value}");
        if(isWeb == true){
          AnchorElement anchorElement = AnchorElement(href: "Download/${shipmentRecord.value}");
          anchorElement.download = "Report_fromedate_to_todate.xlsx";
          anchorElement.click();
          print("object ${anchorElement}");
        }else{
        Download.requestFilePermission(shipmentRecord.value, filename: "Report_fromedate_to_todate");
        }
        Get.offNamed(
          RouteName.homePage,
        );
      } else {
        print("object");
      }
    });
  }

  void getExportBalanceRecord(bool isWeb) {
    reportExportUseCase.getExportBalanceRecord(editConFrom.text.trim(),editConTo.text.trim()).then((value) {
      if (value != null) {
        print("getExportBalanceRecord---------${value.result}");
        balanceRecord.value = value.result['url'];
        print("balanceRecord.value===>>> ${balanceRecord.value}");
        if (isWeb == true) {
          AnchorElement anchorElement =
              AnchorElement(href: "Download/${shipmentRecord.value}");
          anchorElement.download = "Report_fromdate_to_todate";
          anchorElement.click();
          print("object ${anchorElement}");
        } else {
          Download.requestFilePermission(balanceRecord.value,
              filename: "Report_fromdate_to_todate");
        }
        Get.offNamed(
          RouteName.homePage,
        );
      } else {
        print("object");
      }
    });
  }

  void logout() {
    reportExportUseCase.logout().then((value) {
      if (value != null) {
        if (value.isSuccess) {
          Get.back();
          Get.offAllNamed(
            RouteName.root,
          );
          sharedPreferenceController.logout();
        }
        Utils.showSnackbar(value.message ?? []);
      }
    });
  }

/*
  downloadPdfFile(String url, {required String filename}) async {
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
        File file = File('$documentsPath/$filename.xlsx');
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

  Future<bool> requestFilePermission(String url, {required String filename}) async {
    PermissionStatus result;
    AnchorElement anchorElement = AnchorElement(href: "Desktop/$url");
    anchorElement.download = filename;
    anchorElement.click();
    print("object ${anchorElement}");
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }
    if (result.isGranted) {
      print("permission is is for android is granted");
      // downloadPdfFile("http://34.227.86.241:1317/uploads/sendle-print-label/21_10_2022_11_58_45.pdf", filename: "21_10_2022_11_58_45");
      downloadPdfFile(url, filename: filename);
      Utils.showSnackbar("Downloaded");
      return true;
    } else if (Platform.isIOS) {
      result = await Permission.storage.request();
      if (result.isGranted) {
        print("permission is for ios is granted");
        // downloadPdfFile("http://34.227.86.241:1317/uploads/sendle-print-label/21_10_2022_11_58_45.pdf", filename: "21_10_2022_11_58_45");
        downloadPdfFile(url, filename: filename);
        Utils.showSnackbar("Downloaded");
        return true;
      }
    } else {
      print("permission is other issue");
    }
    return false;
  }*/

/*void download(
      List<int> bytes, {
        required String downloadName,
      }) {
    // Encode our file in base64
    final _base64 = base64Encode(bytes);
    // Create the link with the file
    final anchor =
    AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
      ..target = 'blank';
    // add the name
    if (downloadName != null) {
      anchor.download = downloadName;
    }
    // trigger download
    document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }*/

}
