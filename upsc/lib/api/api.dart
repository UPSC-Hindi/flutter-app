class Apis {
  static const String baseUrl = 'https://upsc.trando.in/api/v1/';
  // Please don't remove "/api/v1".
  static const String banner = "adminPanel/getbannerdetails";
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
  //user details
  static const String updateUserDetails = "authentication/UpdateUserDetails";
  static const String updateUserProfilePhoto =
      "authentication/UpdateUserProfilePhoto";

  static const String getCoursesFilter = "adminPanel/getBatchesDetails";
  static const String getCoursesDetails = 'adminPanel/getBatchDetailswithid/';
  static const String getYouTubeVideo = 'adminPanel/YouTubeDetails';

  static const String joinmeeting = "Streaming/JoinMeetingRTCAndRTMToken";
  static const String deleteUserDetailsFromStream =
      "Streaming/deleteUserDetailsFromStream/";
  static const String streamingUserDetails = "Streaming/StreamingUserDetails";

  static const String getResources = "adminPanel/ResourceDetails";

  static const String addtocart = 'adminPanel/addtocart';
  static const String getcartdata = 'adminPanel/getCartDetails';
  static const String mycourses = 'adminPanel/getmybatchdetails';
  static const String addToMyCourses = 'adminPanel/addtomybatch';
  static const String getMyOrders = 'UPSCPayment/userTransactionDetails';
  static const String removefromCart = "adminPanel/deleteCartDetails/";
  static const String getRecordedVideo = "adminPanel/getRecordedVideoStudentSide";
  static const String getBatchNotes = "adminPanel/getNotesOfBatchStudentSide";
  static const String getCourseIndex = 'adminPanel/ResourceDetails';

  //Resources
  static const String getDailyNews = 'adminPanel/getNewsClips';
  static const String getAirResources = 'adminPanel/getallindiaradio';
  static const String getNotesDetails = 'adminPanel/getNotesDetails';

  static const String agora =
      "https://storage-upschindi.s3.ap-south-1.amazonaws.com/data/agora/";

  //Payment
  static const String savePaymentStatus = 'UPSCPayment/verifyUserPayment';
  static const String savetestPaymentStatus = 'UPSCPayment/verifyUserPaymentForTestSeries';
  static const String getOrderId = 'UPSCPayment/orders';

  //Scheduler
  static const String addSchedulardetails = 'adminPanel/addSchedulardetails';
  static const String getScheduleDetails = 'adminPanel/getScheduleDetails';
  static const String deleteScheduler = 'adminPanel/deleteSchedularDetails/';
  static const String updateScheduler = 'adminPanel/updateSchedulardetails/';
  static const String classScheduler = 'adminPanel/getMySchedular';

  static const String getnotification="Notification/getNotifications";
  //TestSeries
  static const String gettestseries="adminPanel/getTestSeriesdetails";
  static const String myTests = 'adminPanel/getMyTestSeries';
  static const String myTestsoftest = 'adminPanel/getTestForTestSeriesDetails';
  static const String submittest = 'adminPanel/addAttemptedTest';
}