///
/// This class contains all URL which is being called to fetch repositories from server
///
class ApiClient {
  static bool isProduction = false;

  static String productionBaseUrl = "";
  static String stagingBaseUrl = "https://d50eb461-bb5a-425f-9d82-4b9e3a6dd080.mock.pstmn.io/v2/";
  // static String stagingBaseUrl = "https://dev.open-api.jumppoint.io/v2/";

  static String productionSocketBaseUrl = "";

  static String stagingSocketBaseUrl = "";

  static String baseUrl = isProduction ? productionBaseUrl : stagingBaseUrl;
  static String socketUrl = isProduction ? productionSocketBaseUrl : stagingSocketBaseUrl;
  static const String jsonAuthenticationName = "Authorization";
  static const String jsonHeaderName = "Content-Type";
  static const String jsonHeaderValue = "application/json; charset=UTF-8";
  static const int successResponse = 200;
  static const int deletedUserCode = 419;
  static const int unauthorised = 401;

  //Auth
  static String register = 'user/register';
  static String login = 'auth/login';
  static String userInfo = 'user/info';
  static String initOtp = 'user/init-otp';
  static String initResetOtp = 'user/reset/init-otp';
  static String verifyResetOtp = 'user/reset/verify-otp';
  static String passwordResetOtp = 'user/reset/password';
  static String verifyOtp = 'user/verify-otp';
  static String deleteAccount = 'user/delete-account';

  //Home Shipment
  static String shipmentStatus = 'shipment/shipment-status-summary';
  static String shipmentList = 'shipment/list';
  static String shipmentDetailsList = 'shipment/details';
  static String shipmentStatusSummary = 'shipment/shipment-status-summary';
  static String labelShipment = 'label/shipment';

  //in app notice
  static String inAppNoticeById = 'in-app-notices/list-by-user';

  ///Create Order

  //Find Date Express / Type
  static String findDateCO = 'date/valid';

  //Parcels
  static String itemOptionCO = 'item/options/';
  static String validateTrackingNoCO = 'shipment/validate-tracking-number/';
  static String itemPreviousParcelCO = 'item/previous-parcel/';

  //Address
  static String pickUpStoreOptionCO = 'pick-up-store/option';
  static String shipmentAddressCO = 'address/merchant/';
  static String addressCO = 'address';
  static String shipmentAddressSearchCO = 'address/search';
  static String areaRankList = 'address/area-rank/list';

  //CheckOut
  static String checkOutPaymentOptionCO = 'shipment/payment-option';

  //Shipment Preview
  static String shipmentPreviewQuotation = 'shipment/quotation/';
  static String createShipmentPreview = 'shipment';

  //Logout
  static String logout = "auth/logout";

  //TopUP
  static String paymentTopUp = "payment/top-up-methods";
  static String paymentTopUpAmountOption = "payment/top-up-amount-option";
  static String paymentTransactionRecord = "payment/logs";
  static String addCardUrl = "payment/add-card-url";

  //BankTransfer
  static String bankTransferAc = "payment/jp-bank-account";

  //Item
  static String statusLog = "item/status-logs";
  static String labelItem = 'label/item';

  //Report Export
  static String exportShipmentReport = "export/shipment-report";
  static String exportBalanceReport = "export/balance-log-report";

  //Update Password
  static String resetPassword = "user/reset/password";

  //Apply Waybills
  static String labelRequest = "label/request";

  Map<String, String> getJsonHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = jsonHeaderValue;
    return header;
  }

  static convertMapToObject<T>(val) {
    if (val is List) {
      final list = <T>[];
      for (var element in val) {
        list.add(getValue<T>(element));
      }
      return list;
    } else {
      return getValue<T>(val);
    }
  }

  static getValue<T>(value) {
    switch (T) {
      // case Post:
      //   return Post.fromJson(value);

      default:
        return value;
    }
  }
}
