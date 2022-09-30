class JoinStreaming {
  bool? status;
  Data? data;
  String? msg;

  JoinStreaming({this.status, this.data, this.msg});

  JoinStreaming.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  String? rtcToken;
  String? rtmToke;

  Data({this.rtcToken, this.rtmToke});

  Data.fromJson(Map<String, dynamic> json) {
    rtcToken = json['RtcToken'];
    rtmToke = json['RtmToke'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['RtcToken'] = rtcToken;
    data['RtmToke'] = rtmToke;
    return data;
  }
}
