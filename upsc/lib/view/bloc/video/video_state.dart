part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();
}

class VideoInitial extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoLoadingState extends VideoState{
  @override
  List<Object?> get props => [];
}
class YoutubeVideoSuccess extends VideoState{
  final List<VideoModel> videoData;

  YoutubeVideoSuccess({required this.videoData});
  @override
  List<Object?> get props => [videoData];

}
class VideoFailureState extends VideoState{
  @override
  List<Object?> get props => [];
}