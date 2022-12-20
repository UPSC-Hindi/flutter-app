// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'network_api.dart';

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= Apis.baseUrl;
  }

  final Dio _dio;

  String? baseUrl;
  @override
  Future<getbannerdetails> bannerimagesRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Resendotp>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.banner,
                    queryParameters: queryParameters)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getbannerdetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Login> loginRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Login>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.login,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Register> registerRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Register>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.register,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Register.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyMobileNumber> verifymobilenumberRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyMobileNumber>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.verifymobilenumber,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyMobileNumber.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Resendotp> resendotpRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Resendotp>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.resendotpm,
                    queryParameters: queryParameters)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Resendotp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgetPassword> forgetpasswordRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgetPassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.forgetpassword,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgetPassword.fromJson(_result.data!);
    return value;
  }

  @override
  passwordverifyotpRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PasswordVerifyOtp>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.passwordverifyotp,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PasswordVerifyOtp.fromJson(_result.data!);
    return value;
  }

  @override
  passwordotpresendRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PasswordOtpResend>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.passwordotpresend,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PasswordOtpResend.fromJson(_result.data!);
    return value;
  }

  @override
  resetpasswordRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.resetpassword,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResetPassword.fromJson(_result.data!);
    return value;
  }

  @override
  logoutRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Logout>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                  _dio.options,
                  Apis.logout,
                  queryParameters: queryParameters,
                )
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Logout.fromJson(_result.data!);
    return value;
  }

  @override
  googleSigninRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GoogleSignIn>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.googleSignIn,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GoogleSignIn.fromJson(_result.data!);
    return value;
  }

  @override
  postUserMobileNumberRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<postUserMobileNumber>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.postUserMobileNumber,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = postUserMobileNumber.fromJson(_result.data!);
    return value;
  }

  @override
  joinmeetingRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<JoinStreaming>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.joinmeeting,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = JoinStreaming.fromJson(_result.data!);
    return value;
  }

  @override
  streaminguserdetailsRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StreamingUserDetails>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.streamingUserDetails,
                    queryParameters: queryParameters)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StreamingUserDetails.fromJson(_result.data!);
    return value;
  }

  @override
  deleteuserdetailsfromstreamRequest(body) async {
    // try {
    //   var response = await dioAuthorizationData()
    //       .delete('${Apis.baseUrl}${Apis.deleteUserDetailsFromStream}$body');
    //   print(response);
    //   final value = DeleteUserDetailsFromStream.fromJson(response.data!);
    //   return value;
    // } catch (error) {
    //   rethrow;
    // }
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteUserDetailsFromStream>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.deleteUserDetailsFromStream,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteUserDetailsFromStream.fromJson(_result.data!);
    return value;
  }

  @override
  addtocartRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddToCart>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.addtocart,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddToCart.fromJson(_result.data!);
    return value;
  }

  @override
  getorderidRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderIdGeneration>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.getOrderId,
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderIdGeneration.fromJson(_result.data!);
    return value;
  }

  @override
  removefromcartRequest(body) async {
    final queryParameters = <String, dynamic>{"id": body};
    final _result = await _dio.delete(
      Apis.baseUrl + Apis.removefromCart,
      queryParameters: queryParameters,
    );
    final value = RemovefromCart.fromJson(_result.data!);
    return value;
  }

    @override
  getnotificationRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationGet>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, Apis.getnotification,
                    queryParameters: queryParameters)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NotificationGet.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
