class Apis {
  static const String baseUrl = 'https://upsc.trando.in/api/v1/';
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
  static const String logout = "Logout";

  static const String googleSignIn = "authentication/googleSignIn";
  static const String postUserMobileNumber = "authentication/postUserMobileNumber";
  //static const String googleSignIn = "authentication/googleSignIn";

  static const String getCoursesFilter = "adminPanel/getBatchesDetails";
  static const String getYouTubeVideo = 'adminPanel/YouTubeDetails';
  static const String joinmeeting = "Streaming/JoinMeetingRTCAndRTMToken";
  static const String getResources = "adminPanel/ResourceDetails";
  static const String putUserStream = 'authentication/updateUserStream';
  static const String putUserLanguage = 'authentication/updateUserLanguage';
  static const String addtocart = 'adminPanel/addtocart';
  static const String getcartdata = 'adminPanel/getCartDetails';
  static const String mycourses = 'adminPanel/getmybatchdetails';
  static const String addToMyCourses = 'adminPanel/addtomybatch';
}
