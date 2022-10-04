class JoinStreaming {
  bool? status;
  String? rtcToken;
  String? rtmToke;
  String? msg;

  JoinStreaming({this.status, this.rtcToken, this.rtmToke, this.msg});

  JoinStreaming.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    rtcToken = json['RtcToken'];
    rtmToke = json['RtmToke'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['RtcToken'] = this.rtcToken;
    data['RtmToke'] = this.rtmToke;
    data['msg'] = this.msg;
    return data;
  }
}