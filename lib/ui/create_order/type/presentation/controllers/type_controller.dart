import 'dart:convert';
import 'dart:core';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jumppoint_app/model/find_date.dart';
import 'package:jumppoint_app/model/user_info.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/create_order/model/address_filter_model.dart';
import 'package:jumppoint_app/ui/create_order/model/address_pick_up_store_option_model.dart';
import 'package:jumppoint_app/ui/create_order/model/address_shipment_merchant_model.dart';
import 'package:jumppoint_app/ui/create_order/model/address_shipment_search_model.dart';
import 'package:jumppoint_app/ui/create_order/model/parcel_item_option_model.dart';
import 'package:jumppoint_app/ui/create_order/model/sameday_parcel_past_record_model.dart';
import 'package:jumppoint_app/ui/create_order/model/standard_parcel_past_record_model.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';
import '../../../model/parcel_model.dart';
import '../../domain/type_use_case.dart';

class TypeController extends SuperController {
  bool isFromeApplyWaybills = false;
  final ProgressController progressController;
  final TypeUseCase typeUseCase;
  final SharedPreferenceController sharedPreferenceController;

  TypeController(this.progressController, this.typeUseCase,
      this.sharedPreferenceController);

  // Common Variables
  RxInt currentTab = 0.obs;
  RxInt currentType = 0.obs;

  // Create Order - Type Page
  RxBool isExpressDeliveryTap = false.obs;
  final TextEditingController editConExpressDeliveryDate =
      TextEditingController();
  final DropdownEditingController expressDeliveryDateController =
      DropdownEditingController();
  final DropdownEditingController parcelPickupDateController = DropdownEditingController();
  RxBool isExpressFilled = false.obs;
  RxBool isPickupDateSelected = false.obs;

  final pickUpDates = <PickUpDates?>[].obs;
  final deliveryDates = <dynamic>[].obs;

  /// Create Order - Address Page
  RxInt currentTypeSender = 0.obs;

  /// Standard flow
  final DropdownEditingController selectSenderController =
      DropdownEditingController();
  final DropdownEditingController selectRecipientController =
      DropdownEditingController();

  //sender
  final TextEditingController senderNameController = TextEditingController();
  final FocusNode focusSenderName = FocusNode();

  final TextEditingController senderNumberController = TextEditingController();
  final FocusNode focusSenderNumber = FocusNode();

  final TextEditingController senderMobileNumberController =
      TextEditingController();
  final FocusNode focusSenderMobileNumber = FocusNode();

  final DropdownEditingController senderAddressController =
      DropdownEditingController();

  //recipient
  final TextEditingController recipientNameController = TextEditingController();
  final FocusNode focusRecipientName = FocusNode();

  final TextEditingController recipientCountryCodeController =
      TextEditingController();
  final FocusNode focusRecipientCountryCode = FocusNode();

  final TextEditingController recipientMobileNumberController =
      TextEditingController();
  final FocusNode focusRecipientMobileNumber = FocusNode();

  final DropdownEditingController recipientAddressController =
      DropdownEditingController();

  //index 1
  RxBool isSelectSenderFilled = false.obs;
  RxBool isSelectRecipientSelected = false.obs;

  final addressData = <Addresses?>[].obs;
  Addresses? senderAddressData;
  Addresses? recipientAddressData;

  //index 2
  RxBool isSelectSenderAddressFilled = false.obs;
  RxBool isSelectRecipientAddressSelected = false.obs;

  final standardCollectionSenderAddress = <CollectionPickUpStore?>[].obs;
  final standardDeliveryRecipientAddress = <CollectionPickUpStore?>[].obs;

  RxString selectSenderAddress = "".obs;
  RxString selectRecipientAddress = "".obs;

  CollectionPickUpStore? senderData;
  CollectionPickUpStore? recipientData;

  /// Express flow
  RxBool isExpressSenderFilled = false.obs;
  RxBool isExpressReceipientFilled = false.obs;

  final DropdownEditingController selectExpressSenderController =
      DropdownEditingController();
  final DropdownEditingController selectExpressReceipientController =
      DropdownEditingController();

  RxString selectSenderDate = "".obs;
  RxString selectRecipientDate = "".obs;

  //filter
  final TextEditingController filterController = TextEditingController();
  final FocusNode focusFilter = FocusNode();

  final filterList = <String>[].obs;

  final filterListShow = <AreaRanks?>[].obs;
  RxString selectAddress = "".obs;

  /*List<String> filterListShow = [
    "元朗 Yuen Long",
    "屯門 Tuen Mun",
    "荃灣 Tsuen Wan",
    "葵青 Kwai Tsing",
    "深水埗 Sham Shui Po",
    "油尖旺 Yau Tsim Mong",
    "九龍城 Kowloon City",
    "黃大仙 Wong Tai Sin",
    "觀塘 Kwun Tong",
    "西貢 Sai Kung",
    "北區 North District",
  ];*/

  // Sender Info
  final TextEditingController senderNameCon = TextEditingController();
  final TextEditingController deleteThisSenderCon = TextEditingController();
  final TextEditingController saveNameCon = TextEditingController();
  final TextEditingController mobileNoCon = TextEditingController();
  final TextEditingController regionCodeCon = TextEditingController();
  final TextEditingController flatOrRoomCon = TextEditingController();
  final TextEditingController floorCon = TextEditingController();
  final TextEditingController buildingOrStreetNoCon = TextEditingController();

  final DropdownEditingController fromController = DropdownEditingController();

  RxBool isFromFilled = false.obs;
  RxBool isCreateShipment = true.obs;
  RxBool isAddNewSender = true.obs;

  RxInt charLengthSenderName = 0.obs;
  RxInt charLengthFlat = 0.obs;
  RxInt charLengthFloor = 0.obs;

  final isSearch = true.obs;

  final TextEditingController enterAddressCon = TextEditingController();

  final addressList = <String>[].obs;

  final FocusNode focusSenderNam = FocusNode();
  final FocusNode focusdeleteThisSender = FocusNode();
  final FocusNode focusMobileNo = FocusNode();
  final FocusNode focusRegionCode = FocusNode();
  final FocusNode focusFlatOrRoom = FocusNode();
  final FocusNode focusFloor = FocusNode();
  final FocusNode focusbuildingOrStreetNo = FocusNode();
  final FocusNode focusEnterAddress = FocusNode();

  // Create Order - Parcels Page
  RxList<ParcelModel> parcelList = <ParcelModel>[].obs;
  // RxList<ParcelModel> pastRecordsList = <ParcelModel>[].obs;

  final standardPreviousItems = <StandardPreviousItems?>[].obs;
  final standardPastRecord = <StandardPreviousItems?>[].obs;

  final samedayPreviousItems = <SamedayPreviousItems?>[].obs;
  final samedayPastRecord = <SamedayPreviousItems?>[].obs;

  RxInt remarkLength = 0.obs;
  RxString? trackingNo = "".obs;

  final category = <ProductCategory?>[].obs;
  final dimension = <Dimension?>[].obs;
  final weight = <Weight?>[].obs;
  final temperature = <Temperature?>[].obs;
  final dimensionThirdParty = <DimensionThirdParty?>[].obs;

  // Checkout
  RxInt currentShipmentCost = (-1).obs;
  RxBool isSelectShipmentCostFilled = false.obs;
  RxBool isSelectShipmentCostSelected = false.obs;

  RxInt currentProductCost = (-1).obs;
  RxBool isSelectProductCostFilled = false.obs;
  RxBool isSelectProductCostSelected = false.obs;

  RxBool isChecked = false.obs;
  final TextEditingController editReceiverPaymentController =
      TextEditingController();
  final TextEditingController editShipmentValueController =
      TextEditingController();
  final FocusNode focusReceiverPayment = FocusNode();
  final FocusNode focusShipmentValue = FocusNode();
  RxString shipmentValue = "".obs;
  RxString receiverValue = "".obs;

  final paymentOptions = <dynamic>[].obs;
  String shipmentPaymentOptions = "";
  String receiverPaymentOptions = "";

  // Search Address
  // final searchAddressList = <dynamic>[].obs;
  final existingAddressList = <AddressesSearch?>[].obs;

  RxString searchAddress = ''.obs;
  RxString currentAddress = ''.obs;

  //Shipment Preview Quotation
  String totalPrice = '';
  String senderName = '';
  String senderNumber = '';
  String senderMobileNumber = '';
  String recipientName = '';
  String recipientNumber = '';
  String recipientMobileNumber = '';
  Rx<UserData?> userData = Rx<UserData?>(null);


  dynamic parcelListMap;


  @override
  void onInit() async {
    super.onInit();
    print("objectobjectobject");
    currentTab.value = 0;
    // currentType.value = 0;
    parcelList.add(ParcelModel(isExpanded: RxBool(true)));
    // onGetPastRecords();
    existingAddressList.clear();
    existingAddressList.value = List.from(existingAddressList);
    isCreateShipment.value = true;
    isAddNewSender.value = true;

    if (Get.arguments != null) {
      if(Get.arguments["isFromeApplyWaybills"] != null) {
        isFromeApplyWaybills = Get.arguments["isFromeApplyWaybills"];
      }
      ///Type
      currentType.value = Get.arguments["currentType"];
      totalPrice = Get.arguments["totalPrice"];

      selectSenderDate = Get.arguments["selectSenderDate"];
      selectRecipientDate = Get.arguments["selectRecipientDate"];

      ///Address
      senderName = Get.arguments["senderName"];
      senderNumber = Get.arguments["senderNumber"];
      senderMobileNumber = Get.arguments["senderMobileNumber"];
      recipientName = Get.arguments["recipientName"];
      recipientNumber = Get.arguments["recipientNumber"];
      recipientMobileNumber = Get.arguments["recipientMobileNumber"];
      senderData = Get.arguments["senderData"];
      recipientData = Get.arguments["recipientData"];

      currentTypeSender = Get.arguments["currentTypeSender"];
      senderAddressData = Get.arguments["senderAddressData"];
      recipientAddressData = Get.arguments["recipientAddressData"];


    ///Checkout
      currentShipmentCost = Get.arguments["currentShipmentCost"];
      currentProductCost = Get.arguments["currentProductCost"];
      receiverValue.value = Get.arguments["receiverValue"];

      shipmentPaymentOptions = Get.arguments["shipmentPaymentOptions"];
      parcelList = Get.arguments["parcelList"];

      print("senderName==>${senderName}");
    }
    // isSelectSenderFilled.value = false;
    // isSelectRecipientSelected.value = false;
    // isCreateShipment.value = true;

    ///API
    getUserInfo();
    getExpressDate();

    getShipmentAddress();
    // getItemOption();
  }

  @override
  void onReady() {
    // TODO: implement onReady
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

  void collapseAll() {
    for (var item in parcelList) {
      item.isExpanded.value = false;
    }
  }

  void resetTypeView() {
    currentType.value = 0;
    isExpressDeliveryTap.value = false;
    editConExpressDeliveryDate.text = "";

    isExpressFilled.value = false;
    isPickupDateSelected.value = false;
  }

  void resetParcelView() {
    parcelList.clear();
    // pastRecordsList.clear();
    parcelList.add(ParcelModel(isExpanded: RxBool(true)));
    // onGetPastRecords();
    remarkLength.value = 0;
  }

  void resetCheckoutView() {
    currentShipmentCost.value = (-1);
    isSelectShipmentCostFilled.value = false;
    isSelectShipmentCostSelected.value = false;

    currentProductCost.value = (-1);
    isSelectProductCostFilled.value = false;
    isSelectProductCostSelected.value = false;

    isChecked.value = false;
    editReceiverPaymentController.text = '';
    editShipmentValueController.text = '';
    shipmentValue.value = "";
    receiverValue.value = "";
  }

  void resetAddressView() {
    currentTypeSender.value = -1;
    isSelectSenderFilled.value = false;
    isSelectRecipientSelected.value = false;
    isSelectSenderAddressFilled.value = false;
    isSelectRecipientAddressSelected.value = false;
    isExpressSenderFilled.value = false;
    isExpressReceipientFilled.value = false;
    senderNameController.clear();
    senderNumberController.clear();
    senderMobileNumberController.clear();
    recipientNameController.clear();
    recipientCountryCodeController.clear();
    recipientMobileNumberController.clear();
    filterController.clear();
  }

  /*void onGetPastRecords() {
    pastRecordsList.add(
      ParcelModel(
          isExpanded: RxBool(false),
          productNature: 'Documents',
          dimension: 'L: Above 60cm',
          weight: '50kg',
          remark: '-18°C'),
    );
    pastRecordsList.add(
      ParcelModel(
          isExpanded: RxBool(false),
          productNature: 'Food',
          dimension: 'L: Above 60cm',
          weight: '45kg',
          remark: 'Room Temp'),
    );
    pastRecordsList.add(
      ParcelModel(
          isExpanded: RxBool(false),
          productNature: 'Utilities',
          dimension: 'M: 31-60cm',
          weight: '35kg',
          remark: '0-4°C'),
    );
    pastRecordsList.add(
      ParcelModel(
          isExpanded: RxBool(false),
          productNature: 'Documents',
          dimension: 'M: 31-60cm',
          weight: '55kg',
          remark: '37°C'),
    );
    pastRecordsList.add(
      ParcelModel(
          isExpanded: RxBool(false),
          productNature: 'Food',
          dimension: 'S: Below 30cm',
          weight: '24kg',
          remark: 'Room Temp'),
    );
    pastRecordsList.add(
      ParcelModel(
          isExpanded: RxBool(false),
          productNature: 'Utilities',
          dimension: 'S: Below 30cm',
          weight: '31kg',
          remark: '11°C'),
    );
  }*/

  void onHandleQRData(ParcelModel model, int index) {
    try {
      parcelList[index] = model;
      parcelList[index].isExpanded.value = true;
      parcelList[index].trackingNoController.value.text =
          model.trackingNo ?? "";
      parcelList[index].weightController.value.text = model.weight ?? "";
      parcelList[index].remarkController.value.text = model.remark ?? "";
      Get.back();
    } catch (e) {
      Logger.dev("Error : ${e.toString()}");
    }
  }


  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      Get.offNamed(RouteName.scanQrCode, arguments: Get.arguments);
    } else if (status.isDenied) {
      print('Permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

 timeFormat(String? time) {
    return DateFormat.Hm().format(DateTime.parse(time!));
  }
  holidayTimeFormat(String? time) {
    return DateFormat.d().format(DateTime.parse(time!));
  }
  ///API

  void getExpressDate() {
    typeUseCase.getExpressDate().then((value) {
      if (value != null) {
        print("getExpressDate---------${value.result}");
        value.result['pickUpDates'].forEach((v) {
          pickUpDates.add(PickUpDates.fromJson(v));
        });
        print("pickUpDates===>>> ${pickUpDates.length}");
        deliveryDates.value = value.result['deliveryDates'];
        print("deliveryDates===>>> ${deliveryDates.length}");
      } else {
        print("object");
      }
    });
  }

  void getValidateTrackingNo(String? validateTrackingNo) {
    typeUseCase.getValidateTrackingNo(validateTrackingNo ?? "").then((value) {
      if (value != null) {
        print("getValidateTrackingNo---------${value.result}");
      } else {
        print("object");
      }
    });
  }

  void getItemOption() {
    typeUseCase
        .getItemOption(currentType.value == 1 ? "standard" : "sameDay")
        .then((value) {
      if (value != null) {
        print("getItemOption---------${value.result}");
        if (currentType.value == 1) {
          category.clear();
          dimension.clear();
          dimensionThirdParty.clear();
          value.result['category'].forEach((v) {
            category.add(ProductCategory.fromJson(v));
          });
          print("category===>>> ${category.length}");
          value.result['dimension'].forEach((v) {
            dimension.add(Dimension.fromJson(v));
          });
          print("dimension===>>> ${dimension.length}");
          value.result['dimensionThirdParty'].forEach((v) {
            dimensionThirdParty.add(DimensionThirdParty.fromJson(v));
          });
          print("dimensionThirdParty===>>> ${dimensionThirdParty.length}");
        }else{
          category.clear();
          dimension.clear();
          weight.clear();
          temperature.clear();
          value.result['category'].forEach((v) {
            category.add(ProductCategory.fromJson(v));
          });
          print("category===>>> ${category.length}");
          value.result['dimension'].forEach((v) {
            dimension.add(Dimension.fromJson(v));
          });
          print("dimension===>>> ${dimension.length}");
          value.result['weight'].forEach((v) {
            weight.add(Weight.fromJson(v));
          });
          print("weight===>>> ${weight.length}");
          value.result['temperature'].forEach((v) {
            temperature.add(Temperature.fromJson(v));
          });
          print("temperature===>>> ${temperature.length}");
        }
      } else {
        print("object");
      }
    });
  }

  void getItemPreviousParcel() {
    typeUseCase
        .getItemPreviousParcel(currentType.value == 1 ? "standard" : "sameDay")
        .then((value) {
      if (value != null) {
        print("getItemPreviousParcel---------${value.result}");
        if (currentType.value == 1) {
          standardPreviousItems.clear();
          value.result['previousItems'].forEach((v) {
            standardPreviousItems.add(StandardPreviousItems.fromJson(v));
          });
          print("standardPreviousItems===>>> ${standardPreviousItems.length}");
        }else{
          samedayPreviousItems.clear();
          value.result['previousItems'].forEach((v) {
            samedayPreviousItems.add(SamedayPreviousItems.fromJson(v));
          });
          print("samedayPreviousItems===>>> ${samedayPreviousItems.length}");
        }
      } else {
        print("object");
      }
    });
  }

  void doPickUpStoreOption() {
    parcelListMap = parcelList.map((element) {
     return{
       "dimensionOptionId" : element.dimensionId,
       "itemTrackingNumber" : element.trackingNo,
       "externalOrderNumber": "in enim",
       "actualWeight" : element.weight,
       "itemNotes" : element.remark,
       "categoryOptionId": element.productNatureId,
       "category" : element.productNature,
       "weightOptionId": element.weightId,
       "temperatureOptionId" : "T01"
     };
    }).toList();
    print("parcelList : $parcelListMap");
    typeUseCase.doPickUpStoreOption(currentType.value == 1 ? "standard" : "sameDay", parcelListMap).then((value) {
      print("doPickUpStoreOption---------${value?.length}");
      if (value != null) {
        value['collectionPickUpStore'].forEach((v) {
          standardCollectionSenderAddress.add(CollectionPickUpStore.fromJson(v));
        });
        print("collectionPickUpStore---------${standardCollectionSenderAddress.length}");
        value['deliveryPickUpStore'].forEach((v) {
          standardDeliveryRecipientAddress.add(CollectionPickUpStore.fromJson(v));
        });
        print("deliveryPickUpStore---------${standardDeliveryRecipientAddress.length}");
        getAddressFilter();
        currentTab.value = 2;
        Get.toNamed(RouteName.coAddressesPage);
      } else {
        print("object");
      }
    });
  }

  void getCheckOut() {
    print("recipientData - ${recipientData?.code}");
    typeUseCase.getCheckOut(recipientData?.code ?? "").then((value) {
      if (value != null) {
        print("getCheckOut---------${value.result}");
        paymentOptions.value = value.result['paymentOptions'];
        currentTab.value = 3;
        Get.toNamed(RouteName.coCheckoutPage);
      } else {
        print("object");
      }
    });
  }

  void getShipmentPreviewQuotation() {
    typeUseCase.getShipmentPreviewQuotation(parcelList.length.toString(), currentType.value == 1 ? "standard" : "sameDay").then((value) {
      if (value != null) {
        print("getShipmentPreviewQuotation---------${value.result['price']}");
        print("currentType=======>> ${currentType.value == 1 ? "standard" : "sameDay"}");
        Get.offAllNamed(RouteName.shipmentPreviewPage,
            arguments: {
          'currentType' : currentType.value,
              'totalPrice' : value.result['price'].toString(),

            'selectSenderDate' : selectSenderDate,
            'selectRecipientDate' : selectRecipientDate,

            'senderName' : senderName,
            'senderNumber' : senderNumber,
            'senderMobileNumber' : senderMobileNumber,
              'recipientName' : recipientName,
              'recipientNumber' : recipientNumber,
              'recipientMobileNumber' : recipientMobileNumber,

              'currentTypeSender' : currentTypeSender,

              'senderData' : senderData ,
              'recipientData' : recipientData ,

              'senderAddressData' : recipientAddressData,
              'recipientAddressData' : recipientAddressData,

              'currentShipmentCost' : currentShipmentCost,
              'currentProductCost' : currentProductCost,
              'receiverValue' : receiverValue.value,
              'parcelList' : parcelList,

              'shipmentPaymentOptions' : shipmentPaymentOptions,

            });
      } else {
        print("object");
      }
    });
  }

  void getUserInfo() {
    typeUseCase.getUserInfo().then((value) {
      if (value != null) {
        print("getUserInfo===>>> ${value.result}");
        userData.value = UserData.fromJson(value.result);
      }
    });
  }

  void doCreateShipment() {
    parcelListMap = parcelList.map((element) {
      return{
        "dimensionOptionId" : element.dimensionId,
        "actualWeight" : element.weight,
        "categoryOptionId": element.productNatureId,
      };
    }).toList();

    Map<String, dynamic> createShipmentData = {
      "destinationAddressId": "et officia eiusmod cillum",
      "items": parcelListMap,
      "originAddressId": "minim do eiusmod in",
      "paymentMethod": shipmentPaymentOptions,
      "sameDayDelivery": false,
      "pickUpStoreCode": "anim reprehenderit cupidatat fugiat",
      "pickUpDate": "9999-12-31",
      "deliveryDate": "9999-12-31",
      "cod": 1,
      "orderNotes": "random order notes",
      "externalOrderNumber": "123456",
      "webhookUrl": "sunt",
    };

    typeUseCase.doCreateShipment(createShipmentData).then((value) {
      if (value != null) {
        print("doCreateShipment===>>> ${value}");
        // Get.offNamed(RouteName.shipmentDone);
      }
    });
  }

  void doAddress() {
    parcelListMap = addressData.map((element) {
      return{
        "address" : element?.address,
        "contactName" : element?.contactName,
        "contactPhone": element?.contactPhone,
        "regionCode" : element?.regionCode,
        "floor" : element?.floor,
        "room": element?.room,
      };
    }).toList();
    typeUseCase.doAddress(parcelListMap , "origin").then((value) {
      print("doAddress---------${value?.length}");
      if (value != null) {
        // value['collectionPickUpStore'].forEach((v) {
        //   standardCollectionSenderAddress.add(CollectionPickUpStore.fromJson(v));
        // });
      } else {
        print("object");
      }
    });
  }

  void getShipmentAddressSearch(String valueSearch) {
    typeUseCase.getShipmentAddressSearch(valueSearch).then((value) {
      if (value != null) {
        print("getShipmentAddressSearch===>>> ${value.result}");
        existingAddressList.clear();
        value.result['addresses'].forEach((v) {
          existingAddressList.add(AddressesSearch.fromJson(v));
        });
        print("existingAddressList===>>> ${existingAddressList.length}");
      }
    });
  }

  void getShipmentAddress() {
    typeUseCase.getShipmentAddress().then((value) {
      if (value != null) {
        print("getShipmentAddress===>>> ${value.result}");
        // shipmentAddressData.value = ShipmentAddressModel.fromJson(value.result);
        value.result['addresses'].forEach((v) {
          addressData.add(Addresses.fromJson(v));
        });
        print("shipmentAddressData===>>> ${addressData.length}");
      }
    });
  }

  void getAddressFilter() {
    typeUseCase.getAddressFilter().then((value) {
      if (value != null) {
        print("getAddressFilter===>>> ${value.result}");
        value.result['areaRanks'].forEach((v) {
          filterListShow.add(AreaRanks.fromJson(v));
        });
        print("filterListShow===>>> ${filterListShow.length}");
      }
    });
  }

  void logout() {
    typeUseCase.logout().then((value) {
      if (value != null) {
        if (value.isSuccess) {
          Get.back();
          Get.offAllNamed(RouteName.root,);
          sharedPreferenceController.logout();
        }
        Utils.showSnackbar(value.message??[]);
      }
    });
  }

}
