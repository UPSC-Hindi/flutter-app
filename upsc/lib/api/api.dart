class Apis {
  static const String baseUrl = 'https://upsc.trando.in/api/v1/';
  // Please don't remove "/api/v1".
  static const String banner = "adminPanel/getbannerdetails";
  //user auth
  static const String login = "authentication/login";
  static const String register = "authentication/userRegister";
  static const String verifymobilenumber = "authentication/verifyMobileNumber";
  static const String resendotpm = "authentication/resendmobileVerificationotp";
  static const String forgetpassword = "authentication/forgetpassword";
  static const String passwordverifyotp = "authentication/reset";
  static const String passwordotpresend = "authentication/resendotp";
  static const String resetpassword = "authentication/resetpassword";
  static const String logout = "authentication/Logout";
  //usergoogle auth
  static const String googleSignIn = "authentication/googleSignIn";
  static const String postUserMobileNumber =
      "authentication/postUserMobileNumber";
  //user details
  static const String updateUserDetails = "authentication/UpdateUserDetails";
  static const String updateUserProfilePhoto =
      "authentication/UpdateUserProfilePhoto";

  static const String getCoursesFilter = "adminPanel/getBatchesDetails";
  static const String getYouTubeVideo = 'adminPanel/YouTubeDetails';

  static const String joinmeeting = "Streaming/JoinMeetingRTCAndRTMToken";
  static const String deleteUserDetailsFromStream =
      "Streaming/deleteUserDetailsFromStream/";
  static const String streamingUserDetails = "Streaming/StreamingUserDetails";

  static const String getResources = "adminPanel/ResourceDetails";

  static const String putUserStream = 'authentication/updateUserStream';
  static const String putUserLanguage = 'authentication/updateUserLanguage';

  static const String addtocart = 'adminPanel/addtocart';
  static const String getcartdata = 'adminPanel/getCartDetails';
  static const String mycourses = 'adminPanel/getmybatchdetails';
  static const String addToMyCourses = 'adminPanel/addtomybatch';
  static const String removefromCart = "adminPanel/deleteCartDetails/";

  static const String agora =
      "https://storage-upschindi.s3.ap-south-1.amazonaws.com/data/agora/";

  //Payment
  static const String savePaymentStatus = 'UPSCPayment/verifyUserPayment';
  static const String getOrderId = 'UPSCPayment/orders';

  //Scheduler
  static const String addSchedulardetails = 'adminPanel/addSchedulardetails';
  static const String getScheduleDetails = 'adminPanel/getScheduleDetails';
  static const String deleteScheduler = 'adminPanel/deleteSchedularDetails/';
  static const String updateScheduler = 'adminPanel/updateSchedulardetails/';
  static const String classScheduler = 'adminPanel/getMySchedular';

  static const String getnotification="Notification/getNotifications";
}
