import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:upsc_web/features/controller/course_controller.dart';
import 'package:upsc_web/utils/utils.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesController coursesController = CoursesController();
  CoursesCubit() : super(CoursesInitial());

  void addToCart({required String courseId}) async {
    if (await coursesController.addCoursesToCart(courseId: courseId)) {
      emit(CartCourseAddSuccess());
    } else {
      emit(CoursesError());
    }
  }

  void deleteCartCourse(
      {required String cartId, required BuildContext context}) async {
    Utils.showLoading(context);
    if (await coursesController.deleteMyCartCourses(cartId)) {
      emit(DeleteCartCourses());
    } else {
      emit(CoursesError());
    }
    Utils.hideLoading(context);
  }
}
