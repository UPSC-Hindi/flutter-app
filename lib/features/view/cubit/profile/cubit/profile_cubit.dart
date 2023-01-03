import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getProfile() async {
    emit(ProfileLoading());
    String? profileImage =
        PreferencesHelper.getString(Preferences.profileImage);
    String? userName = PreferencesHelper.getString(Preferences.name);
    if (profileImage == 'N/A' || userName == 'N/A') {
      emit(PrfileError());
    } else {
      emit(ProfileSuccess(userName: userName!, profileImage: profileImage!));
    }
  }
}
