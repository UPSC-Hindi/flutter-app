import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart' as googleauth;
import 'package:upsc/features/data/remote/models/base_model.dart';
import 'package:upsc/features/data/remote/models/google_auth_model.dart';
import 'package:upsc/features/data/remote/models/login_model.dart';
import 'package:upsc/features/data/remote/models/stream_model.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/features/services/remote_services/auth_services.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class AuthController {
  AuthServices authServices = AuthServices();

  Future<BaseModel> login(dynamic data) async {
    try {
      var response = await authServices.loginServices(data);
      BaseModel baseResponse = BaseModel.fromJson(response);
      if (baseResponse.status) {
        LoginModel user = LoginModel.fromJson(response);
        await SharedPreferenceHelper.setString(
            Preferences.access_token, user.data.accessToken);
        await SharedPreferenceHelper.setString(
            Preferences.name, user.data.fullName);
        await SharedPreferenceHelper.setString(
            Preferences.email, user.data.email);
        await SharedPreferenceHelper.setString(
            Preferences.phoneNUmber, user.data.phoneNumber);
        await SharedPreferenceHelper.setString(
            Preferences.language, user.data.language);
        Languages.isEnglish = user.data.language == "hi" ? false : true;
        await SharedPreferenceHelper.setString(
            Preferences.profileImage, user.data.profilePhoto);
        await SharedPreferenceHelper.setString(
            Preferences.address, user.data.address);
        if (user.data.mobileVerified) {
          await SharedPreferenceHelper.setBoolean(
              Preferences.is_logged_in, true);
        }
        flutterToast(user.msg);
      } else {
        flutterToast(baseResponse.msg);
      }
      return baseResponse;
    } catch (error) {
      print(error);
      flutterToast(error.toString());
      rethrow;
    }
  }

  Future<BaseModel> register(dynamic data) async {
    try {
      dynamic response = await authServices.registerServices(data);
      BaseModel user = BaseModel.fromJson(response);
      if (user.status) {
        await SharedPreferenceHelper.setString(
            Preferences.email, user.data['email']);
        await SharedPreferenceHelper.setString(
            Preferences.auth_token, user.data['token']);
        flutterToast(user.data['mobileNumberVerificationOTP'].toString());
      }
      flutterToast(user.msg);
      return user;
    } catch (error) {
      flutterToast(error.toString());
      rethrow;
    }
  }

  Future<bool> resendOtp() async {
    try {
      dynamic responseJson = await authServices.resendOtpService();
      BaseModel response = BaseModel.fromJson(responseJson);
      if (response.status) {
        flutterToast(response.data['mobileNumberVerificationOTP'].toString());
      }
      flutterToast(response.msg);
      return response.status;
    } catch (error) {
      flutterToast(error.toString());
      rethrow;
    }
  }

  Future<bool> verifyPhoneNumber(dynamic data) async {
    try {
      dynamic responseJson = await authServices.verifyPhoneNumberService(data);
      print(responseJson);

      BaseModel response = BaseModel.fromJson(responseJson);
      if (response.status) {
        await SharedPreferenceHelper.setBoolean(Preferences.is_logged_in, true);
        SharedPreferenceHelper.setString(
            Preferences.access_token, response.data['access_token']);
      }
      flutterToast(response.msg);
      return response.status;
    } catch (error) {
      flutterToast(error.toString());
      rethrow;
    }
  }

  Future<List<bool>> googleAuth() async {
    try {
      googleauth.GoogleSignInAccount? result;
      final _googleSignIn = googleauth.GoogleSignIn();
      result = await _googleSignIn.signIn();
      print('----------------------------------------------');
      print(result!.email);
      await _googleSignIn.signOut();
      //await _googleSignIn.disconnect();
      if (result!.email.isNotEmpty) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        dynamic data = {
          'deviceConfig': androidDeviceInfo.id,
          'DeviceName': androidDeviceInfo.brand,
          'email': result.email,
          'profilePhoto': result.photoUrl,
          'usernameFromGoogle': result.displayName,
        };
        dynamic response = await authServices.googleAuthService(data);
        GoogleAuthModel user = GoogleAuthModel.fromJson(response.data);
        flutterToast(user.msg);
        if (user.status) {
          print(user.data.accessToken);
          SharedPreferenceHelper.setString(
              Preferences.access_token, user.data.accessToken);
          SharedPreferenceHelper.setString(
              Preferences.name, user.data.fullName);
          SharedPreferenceHelper.setString(Preferences.email, user.data.email);
          SharedPreferenceHelper.setString(
              Preferences.profileImage, user.data.profilePhoto);
          SharedPreferenceHelper.setString(
              Preferences.address, user.data.address);
          SharedPreferenceHelper.setString(
              Preferences.language, user.data.language);
          return [user.status, user.data.userMobileNumberVerified];
        }
        return [user.status, false];
      }
      return [false, false];
    } catch (error) {
      print(error);
      flutterToast(error.toString());
      return [false, false];
    }
  }

  Future<bool> updateStreamLanguage({dynamic language, dynamic stream}) async {
    try {
      dynamic responseLanguageJson =
          await authServices.updateLanguage(language);
      BaseModel responseLanguage = BaseModel.fromJson(responseLanguageJson);

      dynamic responseStreamJson = await authServices.updateStream(stream);
      BaseModel responseStream = BaseModel.fromJson(responseStreamJson);

      flutterToast("${responseStream.msg} ${responseLanguage.msg}");
      return responseStream.status && responseLanguage.status;
    } catch (error) {
      flutterToast(error.toString());
      rethrow;
    }
  }

  Future<bool> logout(BuildContext context) async {
    Preferences.onLoading(context);
    try {
      dynamic responseJson = await authServices.logoutService();
      BaseModel response = BaseModel.fromJson(responseJson.data);
      flutterToast(response.msg);
      Preferences.hideDialog(context);
      return response.status;
    } catch (error) {
      Preferences.onLoading(context);
      flutterToast(error.toString());
      return false;
    }
  }

  // Future<bool> updateUserDetails(String fullName, String userAddress) async {
  //   try {
  //     dynamic response =
  //         await authServices.updateUserDetailsService(fullName, userAddress);
  //     BaseModel data = BaseModel.fromJson(response);
  //     if (data.status) {
  //       SharedPreferenceHelper.setString(Preferences.address, userAddress);
  //       SharedPreferenceHelper.setString(Preferences.name, fullName);
  //     }
  //     Util.flutterToast(data.msg);
  //     return data.status;
  //   } catch (error) {
  //     Util.toastMessage(error.toString());
  //     return false;
  //   }
  // }

  // Future<bool> updateUserProfilePhoto(var fileBytes, String imageName) async {
  //   try {
  //     dynamic response = await authServices.updateUserProfilePhotoService(
  //         fileBytes, imageName);
  //     BaseModel data = BaseModel.fromJson(response);
  //     SharedPreferenceHelper.setString(
  //         Preferences.profileImage, data.data['fileUploadedLocation']);
  //     Util.flutterToast(data.msg);
  //     return data.status;
  //   } catch (error) {
  //     Util.toastMessage(error.toString());
  //     return false;
  //   }
  // }

  Future<bool> requestToLogout(String userEmail) async {
    try {
      dynamic response = await authServices.requestToLogoutService(
        {
          'email_phoneNumber': userEmail,
        },
      );
      BaseModel data = BaseModel.fromJson(response.data);
      flutterToast(data.msg);
      return data.status;
    } catch (error) {
      print(error);
      flutterToast(error.toString());
      return false;
    }
  }

  Future<List<Widget>> getBanner() async {
    List<Widget> imageList = [];
    await authServices.getBannerApi().then((value) {
      getbannerdetails response = getbannerdetails.fromJson(value);
      if (response.status!) {
        for (var entry in response.data!) {
          imageList.add(Image.network(entry.bannerUrl!.first));
        }
      } else {
        flutterToast(response.msg!);
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
    return imageList;
  }

  Future<List<String>> getStream() async {
    try {
      List<String> stream = [];
      dynamic response = await authServices.getStreamService();
      var jsonResponse = StreamModel.fromJson(response);
      for (StreamDataModel data in jsonResponse.data) {
        stream.add(data.title);
      }
      return stream;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> resetPasswordVerification(dynamic email_phoneNumber) async {
    try {
      dynamic response = await authServices.resetPasswordVerificationService({
        'email_phoneNumber': email_phoneNumber,
      });
      BaseModel res = BaseModel.fromJson(response.data);
      flutterToast(res.msg);
      flutterToast(res.data['otpToResetPassword'].toString());
      return res.status;
    } catch (error) {
      print(error);
      flutterToast(error.toString());
      return false;
    }
  }

  Future<bool> resetPasswordVerifyOtp(
      String email_phoneNumber, String otp) async {
    try {
      dynamic response = await authServices.resetPasswordVerifyOtpService({
        'email_phoneNumber': email_phoneNumber,
        'otp': otp,
      });
      BaseModel res = BaseModel.fromJson(response.data);
      flutterToast(res.msg);
      return res.status;
    } catch (error) {
      print(error);
      flutterToast(error.toString());
      return false;
    }
  }

  Future<bool> resendPasswordVerifyOtp(String email_phoneNumber) async {
    try {
      dynamic response = await authServices.resendPasswordVerifyOtpService({
        'email_phoneNumber': email_phoneNumber,
      });

      BaseModel res = BaseModel.fromJson(response.data);
      flutterToast(res.msg);
      flutterToast(res.data['otpToResetPassword'].toString());
      return res.status;
    } catch (error) {
      flutterToast(error.toString());
      rethrow;
    }
  }

  Future<bool> updatePassword(dynamic data) async {
    try {
      dynamic response = await authServices.updatePasswordService(data);
      print(response);
      BaseModel res = BaseModel.fromJson(response.data);
      flutterToast(res.msg);
      return res.status;
    } catch (error) {
      print(error);
      flutterToast(error.toString());
      return false;
    }
  }
}
