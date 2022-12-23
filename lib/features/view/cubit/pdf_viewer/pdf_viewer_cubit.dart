import 'dart:html';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:internet_file/internet_file.dart';
import 'package:meta/meta.dart';
part 'pdf_viewer_state.dart';

class PdfViewerCubit extends Cubit<PdfViewerState> {
  PdfViewerCubit() : super(PdfViewerInitial());

  void viewPdf(String url)async{
    emit(PdfViewerLoading());
    print(url);
    try{
      Response response = await Dio().get(
        url,
        // onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      print(response);
      // File file = File(savePath);
      Uint8List bytes = Uint8List(4);
      emit(PdfViewerSuccess(bytes: bytes));
    }catch(error){
      print(error.toString());
      emit(PdfViewerError());
    }
  }
}
