import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upsc_web/features/controller/course_controller.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  CoursesController coursesController = CoursesController();
  addToCart({required String courseId})async{
    if(await coursesController.addCoursesToCart(courseId: courseId)){

    }
  }
}
