part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();
}

class GetYoutubeVideo extends VideoEvent {
  @override
  List<Object?> get props => [];
}
