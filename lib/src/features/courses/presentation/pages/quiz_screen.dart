import 'dart:developer';

import 'package:edu/di.dart';
import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:edu/src/features/courses/data/models/answers_model.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/courses/data/repositories/course_repo.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/quiz_option.dart';
import '../widgets/progress_bar.dart';
import 'package:no_screenshot/no_screenshot.dart';

import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class QuizScreen extends StatefulWidget {
  final CoursesCubit cubit;
  final Quizes quizes;
  const QuizScreen({super.key, required this.quizes, required this.cubit});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> selectedOption = [];
  List<Answers> answersData = [];
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        bool result = await _noScreenshot.screenshotOff();
        debugPrint('Screenshot Off: $result');

        // Save quiz information to shared preferences
        _saveQuizToPrefs();
      },
    );

    selectedOption = List.generate(
      widget.quizes.questions?.length ?? 0,
      (index) => -1,
    );
    answersData = List.generate(
      widget.quizes.questions?.length ?? 0,
      (index) => Answers(),
    );
  }

  @override
  void dispose() {
    // When quiz is properly completed, remove it from shared preferences
    _removeQuizFromPrefs(widget.quizes.quizId.toString());
    super.dispose();
  }

  // Save quiz information to shared preferences
  Future<void> _saveQuizToPrefs() async {
    try {
      final storage = di<FlutterSecureStorage>();
      final quizId = widget.quizes.quizId.toString();
      final courseId = widget.quizes.courseId.toString();

      // Save quiz ID and timestamp to mark it as started
      await storage.write(
          key: 'unfinished_quiz_$quizId',
          value: DateTime.now().toIso8601String());
      await storage.write(
          key: 'unfinished_quiz_course_$quizId', value: courseId);

      log('Saved quiz $quizId to shared preferences');
    } catch (e) {
      log('Error saving quiz to shared preferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.quizes.course?.courseName ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   'Session 1',
                        //   style: TextStyle(
                        //     color: Colors.grey[600],
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 10),
                        TimerCountdown(
                          format: CountDownTimerFormat.minutesSeconds,
                          colonsTextStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          descriptionTextStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          timeTextStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          onEnd: () {
                            Navigator.of(context).pop();
                            AppStates.ErrorToast("Time is up");
                          },
                          endTime: DateTime.now().add(Duration(
                              minutes: int.parse(
                                      "${widget.quizes.quizDuration?.split(":")[1]}")
                                  .toInt())),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // QuizProgressBar(
                //   progress: (pageController.page?.toInt() ?? 0) /
                //       (widget.quizes.questions?.length ?? 0),
                // ),
                const SizedBox(height: 32),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemCount: widget.quizes.questions?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            'Question ${index + 1}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.quizes.questions?[index].question ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Options(
                              quizes: widget.quizes,
                              index: index,
                              selectedOption: selectedOption,
                              answersData: answersData)
                        ],
                      );
                    },
                  ),
                ),

                FutureBuilder(
                    future: Future.value(true),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox.shrink();
                      return ScreenButtons(
                          answersData: answersData,
                          cubit: widget.cubit,
                          pageController: pageController,
                          selectedOption: selectedOption,
                          quizes: widget.quizes);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenButtons extends StatefulWidget {
  final PageController pageController;
  final List<int> selectedOption;
  final List<Answers> answersData;
  final CoursesCubit cubit;
  final Quizes quizes;
  const ScreenButtons(
      {super.key,
      required this.pageController,
      required this.selectedOption,
      required this.answersData,
      required this.cubit,
      required this.quizes});

  @override
  State<ScreenButtons> createState() => _ScreenButtonsState();
}

class _ScreenButtonsState extends State<ScreenButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            if ((widget.pageController.page?.toInt() ?? 0) > 0) {
              widget.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              setState(() {});
            }
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
        ),
        Row(
          children: [
            if ((widget.pageController.page?.toInt() ?? 0) ==
                (widget.quizes.questions?.length ?? 0) - 1)
              BlocBuilder<CoursesCubit, CoursesState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (!widget.selectedOption.contains(-1)) {
                        await widget.cubit.recordQuizScore(widget.answersData,
                            widget.quizes.quizId.toString());
                        final quiz = context
                            .read<CoursesCubit>()
                            .quizes
                            .firstWhere((e) =>
                                e.quizId.toString() ==
                                widget.quizes.quizId.toString());
                        List<Answers> correctAnswers = widget.answersData
                            .where((e) => e.isCorrect == true)
                            .toList();
                        // Calculate the total score by summing up the degrees of correct answers
                        int totalDegree = 0;
                        if (correctAnswers.isNotEmpty) {
                          totalDegree = correctAnswers
                              .map((e) => e.degree ?? 0)
                              .fold(0, (sum, degree) => sum + degree);
                        }
                        quiz.score = totalDegree.toString();

                        // Navigate to the score screen
                        context.goToAndReplace(
                          Routes.scoreRoute,
                          arguments: {
                            'answers': widget.answersData,
                            'quiz': widget.quizes,
                          },
                        );

                        // Remove quiz from shared preferences when completed properly
                        await _removeQuizFromPrefs(
                            widget.quizes.quizId.toString());
                      } else {
                        AppStates.ErrorToast('Please answer all questions');
                      }
                    },
                    child: const Text('Finish',
                        style: TextStyle(color: Colors.white)),
                  );
                },
              )
            else
              TextButton(
                onPressed: () {
                  if ((widget.pageController.page?.toInt() ?? 0) <
                      (widget.quizes.questions?.length ?? 0)) {
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                  setState(() {});
                },
                child: const Text('Next'),
              ),
          ],
        ),
      ],
    );
  }
}

class Options extends StatefulWidget {
  final Quizes quizes;
  final int index;
  final List<int> selectedOption;
  final List<Answers> answersData;
  const Options(
      {super.key,
      required this.quizes,
      required this.index,
      required this.selectedOption,
      required this.answersData});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          for (int i = 0;
              i < (widget.quizes.questions?[widget.index].options?.length ?? 0);
              i++)
            QuizOption(
              optionText:
                  widget.quizes.questions?[widget.index].options?[i] ?? '',
              isSelected: widget.selectedOption[widget.index] == i,
              onTap: () {
                List<String> options =
                    widget.quizes.questions?[widget.index].options ?? [];

                setState(() {
                  if (options[i] ==
                      widget.quizes.questions?[widget.index].correctAnswer) {
                    widget.answersData[widget.index].isCorrect = true;
                  } else {
                    widget.answersData[widget.index].isCorrect = false;
                  }
                  widget.answersData[widget.index].answer = options[i];
                  widget.answersData[widget.index].degree =
                      widget.quizes.questions?[widget.index].marks;
                  widget.selectedOption[widget.index] = i;
                });
              },
            ),
        ],
      ),
    );
  }
}

// Remove quiz from shared preferences when completed properly
Future<void> _removeQuizFromPrefs(String quizId) async {
  try {
    final storage = di<FlutterSecureStorage>();

    await storage.delete(key: 'unfinished_quiz_$quizId');
    await storage.delete(key: 'unfinished_quiz_course_$quizId');

    log('Removed quiz $quizId from shared preferences');
  } catch (e) {
    log('Error removing quiz from shared preferences: $e');
  }
}
