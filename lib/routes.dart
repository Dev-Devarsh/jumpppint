import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:jumppoint_app/ui/account_information/account_information/bindings/account_information_binding.dart';
import 'package:jumppoint_app/ui/account_information/account_information/presentation/views/account_information_view.dart';
import 'package:jumppoint_app/ui/account_information/delete_account/bindings/delete_account_binding.dart';
import 'package:jumppoint_app/ui/account_information/delete_account/presentation/views/delete_account_view.dart';
import 'package:jumppoint_app/ui/account_information/delete_account/presentation/views/sad_to_see_you_leaving_view.dart';
import 'package:jumppoint_app/ui/account_information/update_information/bindings/update_information_binding.dart';
import 'package:jumppoint_app/ui/account_information/update_information/presentation/views/update_information_view.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account/bindings/apply_for_account_binding.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account/presentation/views/apply_for_account_view.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account_done/bindings/apply_for_account_done_binding.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account_done/presentation/views/apply_for_account_done_view.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account_password/bindings/apply_for_account_password_binding.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account_password/presentation/views/apply_for_account_password_view.dart';
import 'package:jumppoint_app/ui/apply_waybills/apply_way_bills/bindings/apply_waybills_binding.dart';
import 'package:jumppoint_app/ui/apply_waybills/apply_way_bills/presentation/views/apply_waybills_view.dart';
import 'package:jumppoint_app/ui/apply_waybills/waybills_address_search/bindings/waybills_address_binding.dart';
import 'package:jumppoint_app/ui/apply_waybills/waybills_address_search/presentation/views/waybills_address_view.dart';
import 'package:jumppoint_app/ui/banktransfer/bindings/bank_transfer_binding.dart';
import 'package:jumppoint_app/ui/banktransfer/presentation/views/bank_transfer_view.dart';
import 'package:jumppoint_app/ui/batch_shipment/batchcreate/bindings/batch_create_binding.dart';
import 'package:jumppoint_app/ui/batch_shipment/batchcreate/presentation/views/batch_create_view.dart';
import 'package:jumppoint_app/ui/batch_shipment/bulkorderpreview/bindings/bulkorder_preview_binding.dart';
import 'package:jumppoint_app/ui/batch_shipment/bulkorderpreview/presentation/views/bulkorder_preview_view.dart';
import 'package:jumppoint_app/ui/browsecargo/bindings/browse_cargo_binding.dart';
import 'package:jumppoint_app/ui/browsecargo/presentation/views/browse_cargo_view.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/bindings/confirm_shipment_binding.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/presentation/views/confirm_shipment_view.dart';
import 'package:jumppoint_app/ui/confirm_shipment/shipment_preview/bindings/shipment_preview_binding.dart';
import 'package:jumppoint_app/ui/confirm_shipment/shipment_preview/presentation/views/shipment_preview_view.dart';
import 'package:jumppoint_app/ui/create_order/addresses/bindings/addresses_binding.dart';
import 'package:jumppoint_app/ui/create_order/addresses/presentation/views/addresses_view.dart';
import 'package:jumppoint_app/ui/create_order/checkout/bindings/type_binding.dart';
import 'package:jumppoint_app/ui/create_order/checkout/presentation/views/checkout_view.dart';
import 'package:jumppoint_app/ui/create_order/parcels/bindings/parcels_binding.dart';
import 'package:jumppoint_app/ui/create_order/parcels/presentation/views/parcels_view.dart';
import 'package:jumppoint_app/ui/create_order/scan_qrcode/qrcode_permission/bindings/qrcode_permission_binding.dart';
import 'package:jumppoint_app/ui/create_order/scan_qrcode/qrcode_permission/presentation/views/qrcode_permission_view.dart';
import 'package:jumppoint_app/ui/create_order/scan_qrcode/scan_code/bindings/scan_code_binding.dart';
import 'package:jumppoint_app/ui/create_order/scan_qrcode/scan_code/presentation/views/scan_code_view.dart';
import 'package:jumppoint_app/ui/create_order/sender_information/search_address/presentation/views/search_address_view.dart';
import 'package:jumppoint_app/ui/create_order/sender_information/sender_info/bindings/sender_info_binding.dart';
import 'package:jumppoint_app/ui/create_order/sender_information/sender_info/presentation/views/sender_info_view.dart';
import 'package:jumppoint_app/ui/create_order/shipment_preview/bindings/shipment_preview_binding.dart';
import 'package:jumppoint_app/ui/create_order/shipment_preview/presentation/views/shipment_preview_view.dart';
import 'package:jumppoint_app/ui/create_order/type/bindings/type_binding.dart';
import 'package:jumppoint_app/ui/create_order/type/presentation/views/type_view.dart';
import 'package:jumppoint_app/ui/forgot_password/forgorpasswordemail/bindings/forgotpasswordemail_binding.dart';
import 'package:jumppoint_app/ui/forgot_password/forgorpasswordemail/presentation/views/forgotpasswordemail_view.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/bindings/forgotpassword_binding.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/presentation/views/forgotpassword_view.dart';
import 'package:jumppoint_app/ui/forgot_password/newpassword/bindings/newpassword_binding.dart';
import 'package:jumppoint_app/ui/forgot_password/newpassword/presentation/views/newpassword_view.dart';
import 'package:jumppoint_app/ui/home/bindings/home_bindings.dart';
import 'package:jumppoint_app/ui/home/presentation/views/home_view.dart';
import 'package:jumppoint_app/ui/languagesetting/bindings/language_settings_binding.dart';
import 'package:jumppoint_app/ui/languagesetting/presentation/views/language_setting_view.dart';
import 'package:jumppoint_app/ui/login/bindings/login_binding.dart';
import 'package:jumppoint_app/ui/login/presentation/views/login_view.dart';
import 'package:jumppoint_app/ui/notification_center/bindings/notification_center_binding.dart';
import 'package:jumppoint_app/ui/notification_center/presentation/views/notification_center_view.dart';
import 'package:jumppoint_app/ui/notificationsettings/bindings/notification_settings_binding.dart';
import 'package:jumppoint_app/ui/notificationsettings/presentation/views/notification_setting_view.dart';
import 'package:jumppoint_app/ui/order_details/bindings/order_detail_bindings.dart';
import 'package:jumppoint_app/ui/order_details/presentation/views/order_detail_view.dart';
import 'package:jumppoint_app/ui/pickup_points/bindings/pickup_point_binding.dart';
import 'package:jumppoint_app/ui/pickup_points/presentation/views/pickup_points_view.dart';
import 'package:jumppoint_app/ui/reportExport/bindings/report_export_binding.dart';
import 'package:jumppoint_app/ui/reportExport/presentation/views/report_export_view.dart';
import 'package:jumppoint_app/ui/settings/bindings/settings_binding.dart';
import 'package:jumppoint_app/ui/settings/presentation/views/settings_view.dart';
import 'package:jumppoint_app/ui/shipmentDone/bindings/shipment_done_binding.dart';
import 'package:jumppoint_app/ui/shipmentDone/presentation/views/shipment_done_view.dart';
import 'package:jumppoint_app/ui/shipment_tracking/bindings/shipment_tracking_binding.dart';
import 'package:jumppoint_app/ui/shipment_tracking/presentation/views/shipment_tracking_view.dart';
import 'package:jumppoint_app/ui/smsVerification/bindings/sms_verification_binding.dart';
import 'package:jumppoint_app/ui/smsVerification/presentation/views/sms_verification_view.dart';
import 'package:jumppoint_app/ui/top_up/bindings/top_up_balance_binding.dart';
import 'package:jumppoint_app/ui/top_up/bindings/top_up_binding.dart';
import 'package:jumppoint_app/ui/top_up/bindings/top_up_successfully_binding.dart';
import 'package:jumppoint_app/ui/top_up/bindings/webview_binding.dart';
import 'package:jumppoint_app/ui/top_up/presentation/views/top_up_balance_view.dart';
import 'package:jumppoint_app/ui/top_up/presentation/views/top_up_successfully_view.dart';
import 'package:jumppoint_app/ui/top_up/presentation/views/top_up_view.dart';
import 'package:jumppoint_app/ui/top_up/presentation/views/webview_view.dart';
import 'package:jumppoint_app/ui/transaction_record/bindings/transaction_record_binding.dart';
import 'package:jumppoint_app/ui/transaction_record/presentation/views/transaction_record_view.dart';
import 'package:jumppoint_app/ui/updatepassword/bindings/updatepassword_binding.dart';
import 'package:jumppoint_app/ui/updatepassword/presentation/views/updatepassword_view.dart';
import 'package:jumppoint_app/ui/upload_completed/bindings/upload_completed_binding.dart';
import 'package:jumppoint_app/ui/upload_completed/presentation/views/upload_completed_view.dart';

import 'ui/create_order/type/bindings/type_binding.dart';
import 'ui/create_order/type/presentation/views/type_view.dart';

class RouteName {
  static const String root = "/";
  static const String homePage = "/HomePage";

  // Apply For Account
  static const String applyForAccount = "/ApplyForAccount";
  static const String applyForAccountPassword = "/ApplyForAccountPassword";

  // Forgot Password
  static const String forgotPassWordPage = "/ForgotPassWordPage";
  static const String forgotPassWordEmailPage = "/ForgotPassWordEmailPage";
  static const String newPassWordPage = "/NewPassWordPage";

  // Shipment Tracking
  static const String shipmentTrackingPage = "/ShipmentTrackingPage";

  // Batch Create
  static const String batchCreatePage = "/BatchCreatePage";
  static const String bulkOrderPreviewPage = "/BulkOrderPreviewPage";
  static const String pickupPointsPage = "/PickupPointsPage";

  // SMS Verification
  static const String smsVerification = "/SmsVerification";
  static const String applyForAccountDone = "/ApplyForAccountDone";
  static const String notificationCenter = "/NotificationCenter";

  //TopUp
  static const String topUp = "/TopUp";
  static const String topUpBalance = "/TopUpBalance";
  static const String topUpSuccessfully = "/TopUpSuccessfully";
  static const String bankTransferView = "/BankTransferView";
  static const String webView = "/Webview";

  // Apply Waybills
  static const String applyWayBills = "/ApplyWayBills";
  static const String wayBillsAddress = "/WayBillsAddress";

  static const String shipmentDone = "/ShipmentDone";
  static const String reportExport = "/ReportExport";
  static const String settings = "/Settings";
  static const String updatePassword = "/UpdatePassword";
  static const String languageSettings = "/LanguageSettings";
  static const String notificationSettings = "/NotificationSettings";

  //Create Order
  static const String coTypePage = "/CreateOrder-Type";
  static const String coParcelsPage = "/CreateOrder-Parcels";
  static const String allowQRPermission = "/Allow-QRPermission";
  static const String scanQrCode = "/Scan-QRCode";
  static const String coAddressesPage = "/CreateOrder-Addresses";
  static const String shipmentPreviewPage = "/Shipment-Preview";
  static const String senderInfoPage = "/Sender-Info";
  static const String searchAddressPage = "/Search-Address";

  //shipment tracking
  static const String coCheckoutPage = "/CreateOrder-Checkout";

//  order details
  static const String orderDetailPage = "/orderDetailPage";

  static const String uploadCompletedView = "/UploadCompletedView";
  static const String transactionRecordView = "/TransactionRecordView";
  static const String browseCargo = "/BrowseCargo";

  // Account Information
  static const accountInfoPage = "/accountInfoPage";

// Update Information
  static const updateInfoPage = "/updateInfoPage";

// Delete Account
  static const deleteAccountPage = "/deleteAccountPage";
  static const sadTOLeaveScreen = "/sadTOLeaveScreen";

  // confirm shipment
  static const String confirmShipment = "/ConfirmShipment";
  static const String confirmShipmentPreview = "/ConfirmShipmentPreview";
}

class Routes {
  static final routes = [
    GetPage(
        page: () => LoginView(),
        name: RouteName.root,
        transition: Transition.noTransition,
        binding: LoginBinding(),
        title: "LoginView"),
    GetPage(
        page: () => HomeView(),
        name: RouteName.homePage,
        transition: Transition.noTransition,
        binding: HomeBinding(),
        title: "HomeView"),
    GetPage(
        page: () => BatchCreateView(),
        name: RouteName.batchCreatePage,
        transition: Transition.noTransition,
        binding: BatchCreateBinding(),
        title: "BatchCreate"),
    GetPage(
        page: () => OrderDetailsView(),
        name: RouteName.orderDetailPage,
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        binding: OrderDetailsBinding(),
        title: "orderDetailView"),
    GetPage(
        page: () => ShipmentTrackingView(),
        name: RouteName.shipmentTrackingPage,
        transition: Transition.noTransition,
        binding: ShipmentTrackingBinding(),
        title: "ShipmentTrackingView"),
    GetPage(
        page: () => ShipmentTrackingView(),
        name: RouteName.shipmentTrackingPage,
        binding: ShipmentTrackingBinding(),
        transition: Transition.noTransition,
        title: "Shipment-Tracking"),
    GetPage(
        page: () => BulkOrderPreviewView(),
        name: RouteName.bulkOrderPreviewPage,
        transition: Transition.noTransition,
        binding: BulkOrderPreviewBinding(),
        title: "BulkOrderPreview"),

    // Create Order Menu
    GetPage(
        page: () => TypeView(),
        name: RouteName.coTypePage,
        transition: Transition.noTransition,
        binding: TypeBinding(),
        title: "CreateOrder"),
    GetPage(
        page: () => ParcelsView(),
        name: RouteName.coParcelsPage,
        transition: Transition.noTransition,
        binding: ParcelBinding(),
        title: "CreateOrder"),
    GetPage(
        page: () => AddressesView(),
        name: RouteName.coAddressesPage,
        transition: Transition.noTransition,
        binding: AddressesBinding(),
        title: "CreateOrder"),
    GetPage(
        page: () => CheckoutView(),
        name: RouteName.coCheckoutPage,
        binding: CheckoutBinding(),
        transition: Transition.noTransition,
        title: "Checkout"),

    GetPage(
        page: () => QrCodePermissionView(),
        name: RouteName.allowQRPermission,
        transition: Transition.noTransition,
        binding: QrCodePermissionBinding(),
        title: "AllowQRPermission"),
    GetPage(
        page: () => ScanCodeView(),
        name: RouteName.scanQrCode,
        transition: Transition.noTransition,
        binding: ScanCodeBinding(),
        title: "ScanQRCode"),

    GetPage(
        page: () => ForgotPasswordView(),
        name: RouteName.forgotPassWordPage,
        transition: Transition.noTransition,
        binding: ForgotPasswordBinding(),
        title: "ForgotPassWord"),
    GetPage(
        page: () => ForgotPasswordEmailView(),
        name: RouteName.forgotPassWordEmailPage,
        transition: Transition.noTransition,
        binding: ForgotPasswordEmailBinding(),
        title: "ForgotPassWordEmail"),

    GetPage(
        page: () => NewPasswordView(),
        name: RouteName.newPassWordPage,
        transition: Transition.noTransition,
        binding: NewPasswordBinding(),
        title: "NewPassWord"),


    GetPage(
        page: () => ApplyForAccountView(),
        name: RouteName.applyForAccount,
        binding: ApplyForAccountBinding(),
        transition: Transition.noTransition,
        title: "ApplyForAccount"),
    GetPage(
        page: () => ApplyForAccountPasswordView(),
        name: RouteName.applyForAccountPassword,
        binding: ApplyForAccountPasswordBinding(),
        transition: Transition.noTransition,
        title: "ApplyForAccountPassword"),

    // Create Order Menu

    GetPage(
        page: () => SmsVerificationView(),
        name: RouteName.smsVerification,
        binding: SmsVerificationBinding(),
        transition: Transition.noTransition,
        title: "SmsVerification"),
    GetPage(
        page: () => ApplyWayBillsView(),
        name: RouteName.applyWayBills,
        binding: ApplyWayBillsBinding(),
        transition: Transition.noTransition,
        title: "ApplyWayBills"),
    GetPage(
        page: () => ApplyForAccountDoneView(),
        name: RouteName.applyForAccountDone,
        binding: ApplyForAccountDoneBinding(),
        transition: Transition.noTransition,
        title: "ApplyForAccountDone"),
    GetPage(
        page: () => WayBillsAddressView(),
        name: RouteName.wayBillsAddress,
        binding: WayBillsAddressBinding(),
        transition: Transition.noTransition,
        title: "WayBillsAddress"),

    GetPage(
        page: () => ShipmentPreviewView(),
        name: RouteName.shipmentPreviewPage,
        transition: Transition.noTransition,
        binding: ShipmentPreviewBinding(),
        title: "shipmentPreview"),
    GetPage(
        page: () => SenderInfoView(
          text: " ",
        ),
        name: RouteName.senderInfoPage,
        transition: Transition.noTransition,
        binding: SenderInfoBinding(),
        title: "senderInfoPage"),
    GetPage(
        page: () => SearchAddressView(),
        name: RouteName.searchAddressPage,
        transition: Transition.noTransition,
        binding: SenderInfoBinding(),
        title: "searchAddressPage"),

    // Account Information
    GetPage(
        page: () => AccountInformationView(),
        name: RouteName.accountInfoPage,
        transition: Transition.noTransition,
        binding: AccountInformationBinding(),
        title: "AccountInformation"),


    GetPage(
        page: () => NotificationCenterView(),
        name: RouteName.notificationCenter,
        binding: NotificationCenterBinding(),
        transition: Transition.noTransition,
        title: "NotificationCenter"),
    GetPage(
        page: () => TopUpView(),
        name: RouteName.topUp,
        binding: TopUpBinding(),
        transition: Transition.noTransition,
        title: "TopUp"),
    GetPage(
        page: () => TopUpBalanceView(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        name: RouteName.topUpBalance,
        binding: TopUpBalanceBinding(),
        title: "TopUp"),
    GetPage(
        page: () => ShipmentDoneView(),
        name: RouteName.shipmentDone,
        binding: ShipmentDoneBinding(),
        transition: Transition.noTransition,
        title: "ShipmentDone"),
    GetPage(
        page: () => SettingsView(),
        name: RouteName.settings,
        binding: SettingsBinding(),
        transition: Transition.noTransition,
        title: "Settings"),

    GetPage(
        page: () => UpdatePasswordView(),
        name: RouteName.updatePassword,
        transition: Transition.noTransition,
        binding: UpdatePasswordBinding(),
        title: "UpdatePassword"),

    GetPage(
        page: () => TransactionRecordView(),
        name: RouteName.transactionRecordView,
        transition: Transition.noTransition,
        binding: TransactionRecordBinding(),
        title: "TransactionRecordView"),
    GetPage(
        page: () => BrowseCargoView(),
        name: RouteName.browseCargo,
        transition: Transition.noTransition,
        binding: BrowseCargoBinding(),
        title: "BrowseCargo"),
    GetPage(
        page: () => BankTransferView(),
        name: RouteName.bankTransferView,
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        binding: BankTransferBinding(),
        title: "BankTransferView"),
    GetPage(
        page: () => TopUpSuccessfullyView(),
        name: RouteName.topUpSuccessfully,
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        binding: TopUpSuccessfullyBinding(),
        title: "topUpSuccessfully"),
    GetPage(
        page: () => UploadCompletedView(),
        name: RouteName.uploadCompletedView,
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        binding: UploadCompletedBinding(),
        title: "BankTransferView"),

    GetPage(
        page: () => LanguageSettingsView(),
        name: RouteName.languageSettings,
        binding: LanguageSettingsBinding(),
        transition: Transition.noTransition,
        title: "LanguageSettings"),
    GetPage(
        page: () => NotificationSettingsView(),
        name: RouteName.notificationSettings,
        transition: Transition.noTransition,
        binding: NotificationSettingsBinding(),
        title: "NotificationSettings"),
    GetPage(
        page: () => ReportExportView(),
        name: RouteName.reportExport,
        transition: Transition.noTransition,
        binding: ReportExportBinding(),
        title: "ReportExport"),
    // Update Information
    GetPage(
        page: () => UpdateInfrormationView(),
        name: RouteName.updateInfoPage,
        transition: Transition.noTransition,
        binding: UpdateInformationBinding(),
        title: "UpdateInformation"),

    // Delete Account
    GetPage(
        page: () => DeleteAccountView(),
        name: RouteName.deleteAccountPage,
        transition: Transition.noTransition,
        binding: DeleteAccountBinding(),
        title: "DeleteAccount"),
    GetPage(
        page: () => SadToSeeYouLeavingView(),
        name: RouteName.sadTOLeaveScreen,
        transition: Transition.noTransition,
        binding: DeleteAccountBinding(),
        title: "DeleteAccount"),

    GetPage(
        page: () => ConfirmShipmentView(),
        name: RouteName.confirmShipment,
        binding: ConfirmShipmentBinding(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        title: "ConfirmShipment"),

    GetPage(
        page: () => ConfirmShipmentPreviewView(),
        name: RouteName.confirmShipmentPreview,
        binding: ConfirmShipmentPreviewBinding(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
        title: "ConfirmShipmentPreview"),

    GetPage(
        page: () => PickupPointsView(),
        name: RouteName.pickupPointsPage,
        binding: PickupPointsBinding(),
        transition: Transition.noTransition,
        title: "PickupPointsPage"),

    GetPage(
        page: () => WebviewScreen(),
        name: RouteName.webView,
        binding: WebviewBinding(),
        transition: Transition.noTransition,
        title: "PickupPointsPage"),

  ];
}