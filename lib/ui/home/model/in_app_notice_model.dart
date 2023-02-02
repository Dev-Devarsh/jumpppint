import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
/*class InAppNoticeResponse{
  List<InAppNotice>? inAppNotice;
  dynamic error;
  int? status;
  String? message;
  int? httpStatus;

  InAppNoticeResponse(
      {
        this.httpStatus = 200,
        this.inAppNotice,
        this.error,
        this.status,
        this.message,
      });



  InAppNoticeResponse.fromJson(Map<String, dynamic> json) {
    InAppNoticeResponse(
        httpStatus: json['httpStatus'] as int? ?? 200,
        error: json['error'],
        status: json['status'] as int?,
        message: json['message'] as String?,
        inAppNotice: List<InAppNotice>.from(
            json["response"].map((x) => InAppNotice.fromJson(x)))
    );
  }
}*/

class InAppNotice{
  String? id;
  String? ititleEnd;
  String? titleZh;
  String? messageEn;
  String? messageZh;
  String? message;
  bool? allowDoNotShowAgain;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdByUid;
  String? updatedByUid;
  String? deletedByUid;

  InAppNotice({
      this.id,
      this.ititleEnd,
      this.titleZh,
      this.messageEn,
      this.messageZh,
      this.message,
      this.allowDoNotShowAgain,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.createdByUid,
      this.updatedByUid,
      this.deletedByUid});

  InAppNotice.fromJson(Map<String, dynamic> json, String lanCode) {
    id = json['id'];
    ititleEnd = json['ititleEnd'];
    titleZh = json['titleZh'];
    messageEn = json['messageEn'];
    messageZh = json['messageZh'];
    allowDoNotShowAgain = json['allowDoNotShowAgain'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    createdByUid = json['createdByUid'];
    updatedByUid = json['updatedByUid'];
    deletedByUid = json['deletedByUid'];
    message = json[lanCode== 'en' ? 'messageEn': 'messageZh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ititleEnd'] = this.ititleEnd;
    data['titleZh'] = this.titleZh;
    data['messageEn'] = this.messageEn;
    data['allowDoNotShowAgain'] = this.allowDoNotShowAgain;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['createdByUid'] = this.createdByUid;
    data['deletedByUid'] = this.deletedByUid;
    data['message'] = this.message;
    return data;
  }
}