import 'dart:developer';

import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/quiz_option.dart';
import '../widgets/progress_bar.dart';

class QuizScreen extends StatefulWidget {
  final Quizes quizes;
  const QuizScreen({super.key, required this.quizes});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> selectedOption = [];
  List<bool> isOptionTrue = [];

  @override
  void initState() {
    super.initState();
    selectedOption = List.generate(
      widget.quizes.questions?.length ?? 0,
      (index) => -1,
    );
    isOptionTrue = List.generate(
      widget.quizes.questions?.length ?? 0,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
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
                    children: [
                      const Icon(Icons.timer_outlined),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.quizes.quizDuration} MIN',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
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
                        Expanded(
                          child: ListView(
                            children: [
                              for (int i = 0;
                                  i <
                                      (widget.quizes.questions?[index].options
                                              ?.length ??
                                          0);
                                  i++)
                                QuizOption(
                                  optionText: widget.quizes.questions?[index]
                                          .options?[i] ??
                                      '',
                                  isSelected: selectedOption[index] == i,
                                  onTap: () {
                                    setState(() {
                                      if (i ==
                                          widget.quizes.questions?[index]
                                              .correctAnswer) {
                                        isOptionTrue[index] = true;
                                      } else {
                                        isOptionTrue[index] = false;
                                      }

                                      selectedOption[index] = i;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              FutureBuilder(
                  future: Future.value(true),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox.shrink();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            if ((pageController.page?.toInt() ?? 0) > 0) {
                              pageController.previousPage(
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
                            if ((pageController.page?.toInt() ?? 0) ==
                                (widget.quizes.questions?.length ?? 0) - 1)
                              ElevatedButton(
                                onPressed: () {
                                  if (!selectedOption.contains(-1)) {
                                    AppStates.SucessToast('Quiz Completed');
                                    context.back();
                                  } else {
                                    AppStates.ErrorToast(
                                        'Please answer all questions');
                                  }
                                },
                                child: const Text('Finish',
                                    style: TextStyle(color: Colors.white)),
                              )
                            else
                              TextButton(
                                onPressed: () {
                                  if ((pageController.page?.toInt() ?? 0) <
                                      (widget.quizes.questions?.length ?? 0)) {
                                    pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
