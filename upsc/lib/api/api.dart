class Apis {
  static const String baseUrl = 'http://3.83.90.66:3000/api/v1/';
  // Please don't remove "/api/v1".

  //user
  static const String login = "authentication/login";
  static const String register = "authentication/userRegister";
  static const String verifymobilenumber = "authentication/verifyMobileNumber";
  static const String resendotpm = "authentication/resendmobileVerificationotp";
  static const String forgetpassword = "authentication/forgetpassword";
  static const String passwordverifyotp = "authentication/reset";
  static const String passwordotpresend = "authentication/resendotp";
  static const String resetpassword = "authentication/resetpassword";
}
