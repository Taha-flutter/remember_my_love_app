class NotificationModel {
  String? sId;
  String? senderMode;
  String? flag;
  String? message;
  List<Payload>? payload;
  String? title;
  bool? seen;
  String? receiver;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationModel(
      {this.sId,
      this.senderMode,
      this.flag,
      this.message,
      this.payload,
      this.title,
      this.seen,
      this.receiver,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderMode = json['senderMode'];
    flag = json['flag'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
      });
    }
    title = json['title'];
    seen = json['seen'];
    receiver = json['receiver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['senderMode'] = this.senderMode;
    data['flag'] = this.flag;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['seen'] = this.seen;
    data['receiver'] = this.receiver;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Payload {
  String? memoryId;

  Payload({this.memoryId});

  Payload.fromJson(Map<String, dynamic> json) {
    memoryId = json['memoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memoryId'] = this.memoryId;
    return data;
  }
}
