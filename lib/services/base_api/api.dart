class Api {
  static const String baseUrl = 'https://upsc.trando.in/api/v1/';

  //BANNER
  static const String getBanner = 'adminPanel/getbannerdetails';

  //AUTH
  static const String login = 'authentication/login';
  static const String googleSignIn = "authentication/googleSignIn";
  static const String register = 'authentication/userRegister';
  static const String resendMobileVerificationOtp =
      'authentication/resendmobileverificationotp';
  static const String googleAuth = 'authentication/googleSignIn';
  static const String verifyMobileNumber = 'authentication/verifyMobileNumber';
  static const String getCategoryStream = 'adminPanel/getCategory?type=Stream';
  static const String updateUserStream = 'authentication/updateUserStream';
  static const String updateUserLanguage = 'authentication/updateUserLanguage';
  static const String logout = "authentication/Logout";
  static const String requestToLogout = 'adminPanel/postRequestToLogoutUserByAdmin';
  //RESET OTP
  static const String resetPassword = 'authentication/forgetpassword';
  static const String resetPasswordVerifyOtp = 'authentication/reset';
  static const String resendOtp = 'authentication/resendotp';
  static const String updatePassword = 'authentication/resetpassword';
  //PROFILE
  static const String updateUserProfileInfo =
      "authentication/UpdateUserDetails";
  static const String updateUserProfilePhoto =
      "authentication/UpdateUserProfilePhoto";

  //COURSES
  static const String getCourses = "adminPanel/getBatchesDetails";
  static const String getCoursesDetails = 'adminPanel/getBatchDetailswithid/';
  static const String addCoursesToCart = 'adminPanel/addtocart';
  static const String getCartCourses = 'adminPanel/getCartDetails';
  static const String getMyCourses = 'adminPanel/getmybatchdetails';
  static const String addToMyCourses = 'adminPanel/addtomybatch';
  static const String getMyCoursesOrders = 'UPSCPayment/userTransactionDetails';
  static const String deleteFromCart = "adminPanel/deleteCartDetails/";

  //Payment
  static const String getOrderId = 'UPSCPayment/orders';
  // static const String getRecordedVideo = "adminPanel/getRecordedVideoStudentSide";
  // static const String getBatchNotes = "adminPanel/getNotesOfBatchStudentSide";

  //Resources
  static const String getCourseIndex = 'adminPanel/ResourceDetails';
  static const String getDailyNews = 'adminPanel/getNewsClips';
  static const String getAirResources = 'adminPanel/getallindiaradio';
  static const String getNotes = 'adminPanel/getNotesDetails';
  static const String getYouTubeVideo = 'adminPanel/YouTubeDetails';


  //Scheduler
  static const String getMyScheduler = 'adminPanel/getScheduleDetails';
  static const String getClassScheduler = 'adminPanel/getMySchedular';

}
