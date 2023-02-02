import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/create_order/model/parcel_model.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utills/colors.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../../domain/login_use_case.dart';

class LoginController extends SuperController {
  final ProgressController progressController;
  final LoginUseCase loginUseCase;
  final SharedPreferenceController sharedPreferenceController;

  LoginController(this.progressController, this.loginUseCase,
      this.sharedPreferenceController);

  final TextEditingController editConEmail = TextEditingController();
  final TextEditingController editConPassword = TextEditingController();

  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();

  bool checkValidation() {
    return true;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
  }

  @override
  void onReady() {
    super.onReady();
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

  Future<void> jsonToExcel() async {
    List<ParcelModel> list = [];
    list.add(ParcelModel(
        productNature: "Name1",
        trackingNo: "0001",
        dimension: "123",
        weight: "12Kg",
        temperature: "24c",
        remark: "No Remarks",
        isExpanded: RxBool(false)));
    list.add(ParcelModel(
        productNature: "Name2",
        trackingNo: "0002",
        dimension: "23",
        weight: "15Kg",
        temperature: "21c",
        remark: "No Remarks",
        isExpanded: RxBool(false)));
    list.add(ParcelModel(
        productNature: "Name3",
        trackingNo: "0003",
        dimension: "12",
        weight: "25Kg",
        temperature: "25c",
        remark: "No Remarks",
        isExpanded: RxBool(false)));
    list.add(ParcelModel(
        productNature: "Name4",
        trackingNo: "0004",
        dimension: "15",
        weight: "31Kg",
        temperature: "11c",
        remark: "No Remarks",
        isExpanded: RxBool(false)));

    var excel = Excel.createExcel(); //create an excel sheet
    Sheet sheetObject = excel['JumpPoint_export']; //create an sheet object
    onGetColumnCells(sheetObject);

    for (int i = 0; i < list.length; i++) {
      onInsertValue(sheetObject, "A${i + 2}", list[i].trackingNo);
      onInsertValue(sheetObject, "B${i + 2}", list[i].productNature);
      onInsertValue(sheetObject, "C${i + 2}", list[i].dimension);
      onInsertValue(sheetObject, "D${i + 2}", list[i].weight);
      onInsertValue(sheetObject, "E${i + 2}", list[i].temperature);
      onInsertValue(sheetObject, "F${i + 2}", list[i].remark);
      onInsertValue(
          sheetObject, "G${i + 2}", list[i].isExpanded.value.toString());
    }

    List<int>? data = excel.encode();
    if (data != null) {
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/JumpPoint_export.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);

      Logger.dev("Length:${file.length()}");
      Logger.dev("Path:${file.path}");
    }
  }

  void onGetColumnCells(Sheet sheetObject) {
    var trackingColumn = sheetObject.cell(CellIndex.indexByString('A1'));
    var productNatureColumn = sheetObject.cell(CellIndex.indexByString('B1'));
    var dimensionColumn = sheetObject.cell(CellIndex.indexByString('C1'));
    var weightColumn = sheetObject.cell(CellIndex.indexByString('D1'));
    var temperatureColumn = sheetObject.cell(CellIndex.indexByString('E1'));
    var remarkColumn = sheetObject.cell(CellIndex.indexByString('F1'));
    var isExpandedColumn = sheetObject.cell(CellIndex.indexByString('G1'));
    trackingColumn.value = "Tracking No.";
    productNatureColumn.value = "Product Nature";
    dimensionColumn.value = "Dimension";
    weightColumn.value = "Weight";
    temperatureColumn.value = "Temperature";
    remarkColumn.value = "Remarks";
    isExpandedColumn.value = "iExpanded";
  }

  void onInsertValue(Sheet sheetObject, String columnName, String? trackingNo) {
    var column = sheetObject.cell(CellIndex.indexByString(columnName));
    column.value = trackingNo ?? "";
  }

  void onGetLogin() {
    loginUseCase
        .doLogin(editConEmail.value.text.toString().trim(),
            editConPassword.value.text.toString().trim())
        .then((value) {
      if (value != null) {
        sharedPreferenceController.saveToken(PrefKeys.token, value['access_token'] ?? "");
        sharedPreferenceController.saveToken(PrefKeys.refreshToken, value['refresh_token'] ?? "");
        sharedPreferenceController.setLogin(true);
        Get.offNamed(RouteName.homePage);
      }
    });
  }

  void initOTP() {
    loginUseCase
        .doInitOtp(editConEmail.value.text.toString().trim())
        .then((value) {
      print("ValueL>Login===>> ${value!['phone']}");
      if (value != null) {
        Get.toNamed(RouteName.forgotPassWordPage, arguments: {"email": editConEmail.value.text.toString().trim(),"phoneNumber":value['phone']});
      }
    });
  }
}
