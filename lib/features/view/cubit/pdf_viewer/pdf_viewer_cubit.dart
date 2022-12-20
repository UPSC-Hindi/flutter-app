import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
part 'pdf_viewer_state.dart';

class PdfViewerCubit extends Cubit<PdfViewerState> {
  PdfViewerCubit() : super(PdfViewerInitial());

  void viewPdf(String url)async{
    emit(PdfViewerLoading());
    try{
      print("getting response");
      print(url);
      dynamic response = await Dio().download(url,'view.pdf');
      print("got response");
      print(response);
      emit(PdfViewerSuccess());
    }catch(error){
      print(error.toString());
      emit(PdfViewerError());
    }
  }
}
