import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/bloc/resources/resources_bloc.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  initState() {
    context.read<ResourcesBloc>().add(const GetResources(filter: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          iconTheme: IconThemeData(color: ColorResources.textblack),
          title: Text(
            'Resources',
            style: TextStyle(color: ColorResources.textblack),
          ),
        ),
        body: BlocBuilder<ResourcesBloc, ResourcesState>(
            builder: (context, state) {
          if (state is ResourcesError) {
            return const Text('Something went wrong');
          }
          if (state is ResourcesSuccess) {
            List<Data> resourcesList = state.resources.data!;
            if (resourcesList.isEmpty) {
              return const Center(
                child: Text('There Is no Resources'),
              );
            }
            return GridView.count(
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('dailynews'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorResources.gray,
                    ),
                    child: Center(
                      child: Text(
                        'Daily News',
                        style: TextStyle(color: ColorResources.textWhite),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorResources.gray,
                    ),
                    child: Center(
                      child: Text(
                        'Course Index',
                        style: TextStyle(color: ColorResources.textWhite),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('shortnotes'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorResources.gray,
                    ),
                    child: Center(
                      child: Text(
                        'Short Notes',
                        style: TextStyle(color: ColorResources.textWhite),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('youtubenotes'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorResources.gray,
                    ),
                    child: Center(
                      child: Text(
                        'YouTube Notes',
                        style: TextStyle(color: ColorResources.textWhite),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('samplenotes'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorResources.gray,
                    ),
                    child: Center(
                      child: Text(
                        'Sample Notes',
                        style: TextStyle(color: ColorResources.textWhite),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
