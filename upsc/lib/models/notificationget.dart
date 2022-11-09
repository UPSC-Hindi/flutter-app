class NotificationGet {
  bool? status;
  List<Data>? data;
  String? msg;

  NotificationGet({this.status, this.data, this.msg});

  NotificationGet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  String? batchDetails;
  String? batchName;

  Data({this.batchDetails, this.batchName});

  Data.fromJson(Map<String, dynamic> json) {
    batchDetails = json['batchDetails'];
    batchName = json['batchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['batchDetails'] = batchDetails;
    data['batchName'] = batchName;
    return data;
  }
}
