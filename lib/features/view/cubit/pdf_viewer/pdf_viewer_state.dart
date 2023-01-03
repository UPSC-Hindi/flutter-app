part of 'pdf_viewer_cubit.dart';

@immutable
abstract class PdfViewerState {}

class PdfViewerInitial extends PdfViewerState {}
class PdfViewerLoading extends PdfViewerState {}
class PdfViewerSuccess extends PdfViewerState {
  final Uint8List bytes;

  PdfViewerSuccess({required this.bytes});
}
class PdfViewerError extends PdfViewerState {}
