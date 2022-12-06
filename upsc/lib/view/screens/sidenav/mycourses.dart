import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/view/screens/course/courseview.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ApiBloc>().add(GetMyCourses());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'My Courses',
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text('Pls Refresh (or) Reopen App'),
            );
          }
          if (state is ApiMyCoursesSuccess) {
            if (state.myCourses.isEmpty) {
              return EmptyWidget(
                text: 'There are no courses',
                image: SvgImages.emptyCard,
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.myCourses.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _myCoursesCardWidget(
                    context,
                    state.myCourses[index],
                  ),
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Center _myCoursesCardWidget(
      BuildContext context, MyCoursesDataModel courseData) {
    print("courses status");
    print(courseData.batchDetails.isActive);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseData.batchDetails.batchName,
                style:  GoogleFonts.notoSansDevanagari(fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expires in ${courseData.batchDetails.endingDate.difference(DateTime.now()).inDays} Days',
                    style: GoogleFonts.notoSansDevanagari(
                        color: ColorResources.gray),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorResources.textblack.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if(courseData.batchDetails.isActive){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CourseViewScreen(
                              lecture: courseData.lectureDetails,
                              batch: courseData.batchDetails,
                            ),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(courseData.batchDetails.isActive?'Continue':'Expired'), // <-- Text
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
