import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_file/internet_file.dart';
import 'package:url_launcher/url_launcher.dart';

part 'file_view_state.dart';

class FileViewCubit extends Cubit<FileViewState> {
  FileViewCubit() : super(PdfViewerInitial());

  void viewPdf({required String url, required String fileType}) async {
    print(fileType);
    print(url);
    emit(PdfViewerLoading());
    try {
      if (fileType == 'video') {
        emit(VideoViewSuccess());
      } else if (fileType == 'link') {
        if (!await launchUrl(Uri.parse(url))) {
          throw 'Could not launch $url';
        }
        emit(LinkViewSuccess());
      } else if (fileType == 'yt_videos') {
        emit(YouTubeVideoViewSuccess());
      } else {
        Uint8List bytes = await InternetFile.get(url);
        emit(PdfViewerSuccess(bytes: bytes));
      }
    } catch (error) {
      emit(PdfViewerError());
    }
  }
}
