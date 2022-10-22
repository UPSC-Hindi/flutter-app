class JoinStreaming {
  bool? status;
  String? appID;
  String? aPPCERTIFICATE;
  String? rtcToken;
  String? rtmToke;
  int? userRole;
  String? msg;

  JoinStreaming(
      {this.status,
      this.appID,
      this.aPPCERTIFICATE,
      this.rtcToken,
      this.rtmToke,
      this.userRole,
      this.msg});

  JoinStreaming.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    appID = json['App_ID'];
    aPPCERTIFICATE = json['APP_CERTIFICATE'];
    rtcToken = json['RtcToken'];
    rtmToke = json['RtmToke'];
    userRole = json['userRole'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['App_ID'] = appID;
    data['APP_CERTIFICATE'] = aPPCERTIFICATE;
    data['RtcToken'] = rtcToken;
    data['RtmToke'] = rtmToke;
    data['userRole'] = userRole;
    data['msg'] = msg;
    return data;
  }
}
