import 'dart:io';

import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:flutter/material.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/project_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';

class ProjectScreen extends StatelessWidget {
  final Assignment assignment;
  bool isAssignment = true;
  final CoursesCubit cubit;

  ProjectScreen(
      {super.key,
      required this.assignment,
      this.isAssignment = true,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Programming Projects',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            return Column(
              children: [
                ProjectCard(
                  title: assignment.assignTitle ?? "",
                  description: assignment.assignDescription ?? "",
                  dueDate: assignment.assignDuedate ?? DateTime.now(),
                  onViewInstructions: () {
                    //      context.goTo(Routes.quizRoute);
                  },
                  onUpload: () async {
                    // Handle file upload
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      cubit.fileData = File(result.files.single.path!);
                      AppStates.SucessToast("File uploaded successfully");
                    } else {
                      AppStates.ErrorToast("Please select a file");
                    }
                  },
                  onSubmit: () {
                    if (cubit.fileData != null) {
                      if (isAssignment) {
                        cubit.uplodeAssignment(
                            assignment, cubit.fileData!, context);
                      } else {
                        cubit.uplodeProject(
                            assignment, cubit.fileData!, context);
                      }
                    } else {
                      AppStates.ErrorToast("Please select a file");
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
