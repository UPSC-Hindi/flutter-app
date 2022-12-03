
class Api{
  static const String baseUrl = 'https://upsc.trando.in/api/v1/';

  //BANNER
  static const String getBanner = 'adminPanel/getbannerdetails';

  //AUTH
  static const String login = 'authentication/login';
  static const String googleSignIn = "authentication/googleSignIn";
  static const String register = 'authentication/userRegister';
  static const String resendMobileVerificationOtp = 'authentication/resendmobileverificationotp';
  static const String verifyMobileNumber = 'authentication/verifyMobileNumber';
  static const String getCategoryStream = 'adminPanel/getCategory?type=Stream';
}