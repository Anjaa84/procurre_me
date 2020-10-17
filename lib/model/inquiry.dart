class Inquiry {

  static const tblInquiry = 'inquiry';
  static const colId = 'inquiryId';
  static const colInquiryMsg = 'inquiryMessage';
  static const colOrderId = 'orderId';

  Inquiry({this.inquiryId,this.inquiryMessage,this.orderId});

  int inquiryId;
  String inquiryMessage;
  int orderId;

  Inquiry.fromMap(Map<String, dynamic> map) {
    inquiryId = map[colId];
    inquiryMessage = map[colInquiryMsg];
    orderId = map[colOrderId];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colInquiryMsg: inquiryMessage, colOrderId: orderId};
    if (inquiryId != null) {
      map[colId] = inquiryId;
    }
    return map;
  }
}