part of 'file_view_cubit.dart';

@immutable
abstract class FileViewState {}

class PdfViewerInitial extends FileViewState {}
class PdfViewerLoading extends FileViewState {}
class PdfViewerSuccess extends FileViewState {
  final Uint8List bytes;
  PdfViewerSuccess({required this.bytes});
}
class PdfViewerError extends FileViewState {}
class YouTubeVideoViewSuccess extends FileViewState {}
class VideoViewSuccess extends FileViewState {}
class LinkViewSuccess extends FileViewState {}
