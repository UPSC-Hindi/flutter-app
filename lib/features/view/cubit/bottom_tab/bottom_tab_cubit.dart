import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_tab_state.dart';

class BottomTabCubit extends Cubit<BottomTabState> {
  BottomTabCubit() : super(BottomTabInitial());

  void homeTab(){
    print('home cubit tab');
    emit(HomeTabState());
  }
  void courseTab(){
    print('course cubit tab');
    emit(CourseTabState());
  }
  void mockTestTab(){
    print('mocktest cubit tab');
    emit(MockTestTabState());
  }
  void profileTab(){
    print('profile cubit tab');
    emit(ProfileTabState());
  }
}
