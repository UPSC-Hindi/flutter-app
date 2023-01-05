import 'dart:html';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:internet_file/internet_file.dart';
import 'package:meta/meta.dart';

part 'pdf_viewer_state.dart';

class PdfViewerCubit extends Cubit<PdfViewerState> {
  PdfViewerCubit() : super(PdfViewerInitial());

  void viewPdf(String url) async {
    emit(PdfViewerLoading());
    print(url);
    try {
      Uint8List bytes = await InternetFile.get(url);
      emit(PdfViewerSuccess(bytes: bytes));
    } catch (error) {
      emit(PdfViewerError());
    }
  }
}
