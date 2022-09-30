import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upsc/services/video_services.dart';

import '../../../models/vidoe_model.dart';
import '../../../util/prefConstatnt.dart';
import '../../../util/preference.dart';

part 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    VideoServices videoServices = VideoServices();
    var token = SharedPreferenceHelper.getString(Preferences.access_token);
    on<GetYoutubeVideo>((event, emit) async {
      emit(VideoLoadingState());
      try {
        if (token != null) {
          var response = await videoServices.getVideo(token);

          if (response.data['status'] == true) {
            var recordSnapshots = response.data['data'] as List;

            List<VideoModel> dataList = [];
            for(var data in recordSnapshots){
              dataList.add(VideoModel.fromJson(data));
            }

            // emit(YoutubeVideoSuccess(
            //     videoData: recordSnapshots.map((video) {
            //   print("--sk-video-sk--");
            //   print(video);
            //   print("--video--");
            //   VideoModel videoData = VideoModel.fromJson(video);
            //   return videoData;
            // }).toList()));

            //
            emit(YoutubeVideoSuccess(videoData: dataList));
          } else {
            emit(VideoFailureState());
          }
        } else {
          emit(VideoFailureState());
        }
      } catch (error) {
        emit(VideoFailureState());
      }
    });
  }
}
