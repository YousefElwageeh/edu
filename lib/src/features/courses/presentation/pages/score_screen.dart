// Used for colors in the score screen
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/styles.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/data/models/answers_model.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreScreen extends StatelessWidget {
  final List<Answers> answers;
  final Quizes quiz;

  const ScoreScreen({
    Key? key,
    required this.answers,
    required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate score statistics
    final int totalQuestions = quiz.questions?.length ?? 0;
    final int correctAnswers = answers.where((a) => a.isCorrect == true).length;
    final int totalScore = answers
        .where((a) => a.isCorrect == true)
        .fold(0, (sum, answer) => sum + (answer.degree ?? 0));
    final int totalPossibleScore = quiz.questions?.fold<int>(
            0, (sum, question) => sum + (question.marks ?? 0)) ??
        0;
    final double percentageScore =
        totalPossibleScore > 0 ? (totalScore / totalPossibleScore) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results',
          style: font16BlackBold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Course name and quiz title
              Text(
                quiz.course?.courseName ?? 'Course',
                style: font24BlackBold,
                textAlign: TextAlign.center,
              ),
              verticalSpace(8),
              Text(
                quiz.quizTitle ?? 'Quiz',
                style: font16BlackBold,
                textAlign: TextAlign.center,
              ),
              verticalSpace(30),

              // Animation based on score
              _buildScoreAnimation(percentageScore),
              verticalSpace(20),

              // Score display
              _buildScoreDisplay(totalScore, totalPossibleScore, percentageScore),
              verticalSpace(30),

              // Statistics cards
              _buildStatisticsCards(totalQuestions, correctAnswers),
              verticalSpace(30),

              // Questions review
              _buildQuestionsReview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreAnimation(double percentageScore) {
    return Container(
      height: 200.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              percentageScore >= 60 ? Icons.check_circle : Icons.cancel,
              size: 80.r,
              color: percentageScore >= 60
                  ? Colors.green
                  : ColorsManager.error,
            ),
            verticalSpace(10),
            Text(
              _getScoreMessage(percentageScore),
              style: font16BlackBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreDisplay(int score, int totalPossible, double percentage) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: font16BlackBold,
          ),
          verticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(percentage),
                ),
              ),
              Text(
                '/$totalPossible',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          verticalSpace(15),
          // Progress indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(_getScoreColor(percentage)),
              minHeight: 10.h,
            ),
          ),
          verticalSpace(8),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: _getScoreColor(percentage),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(int totalQuestions, int correctAnswers) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Questions',
            totalQuestions.toString(),
            Icons.help_outline,
            Colors.blue,
          ),
        ),
        horizontalSpace(15),
        Expanded(
          child: _buildStatCard(
            'Correct Answers',
            correctAnswers.toString(),
            Icons.check_circle_outline,
            Colors.green,
          ),
        ),
        horizontalSpace(15),
        Expanded(
          child: _buildStatCard(
            'Wrong Answers',
            (totalQuestions - correctAnswers).toString(),
            Icons.cancel_outlined,
            Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30.r),
          verticalSpace(10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          verticalSpace(5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsReview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questions Review',
          style: font16BlackBold,
        ),
        verticalSpace(15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quiz.questions?.length ?? 0,
          itemBuilder: (context, index) {
            final question = quiz.questions?[index];
            final answer = answers[index];
            final bool isCorrect = answer.isCorrect ?? false;

            return Container(
              margin: EdgeInsets.only(bottom: 15.h),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: isCorrect ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCorrect ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question?.question ?? '',
                              style: font16BlackBold,
                            ),
                            verticalSpace(10),
                            Row(
                              children: [
                                _buildAnswerChip(
                                  'Your Answer:',
                                  answer.answer ?? 'Not answered',
                                  isCorrect ? Colors.green : Colors.red,
                                ),
                              ],
                            ),
                            if (!isCorrect) ...[  
                              verticalSpace(5),
                              Row(
                                children: [
                                  _buildAnswerChip(
                                    'Correct Answer:',
                                    question?.correctAnswer ?? '',
                                    Colors.green,
                                  ),
                                ],
                              ),
                            ],
                            verticalSpace(5),
                            Text(
                              'Points: ${isCorrect ? answer.degree : 0}/${question?.marks ?? 0}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                        size: 24.r,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnswerChip(String label, String answer, Color color) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$label ',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: answer,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get appropriate message based on score percentage
  String _getScoreMessage(double percentage) {
    if (percentage >= 90) return 'Excellent!';
    if (percentage >= 80) return 'Great Job!';
    if (percentage >= 70) return 'Good Work!';
    if (percentage >= 60) return 'Not Bad!';
    if (percentage >= 50) return 'You Passed!';
    return 'Try Again!';
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }
}
