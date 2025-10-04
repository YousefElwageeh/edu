import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/styles.dart';
import 'package:edu/src/config/utils/common_widgets/custom_button.dart';
import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// A dialog widget for creating new calendar events
class EventCreationDialog extends StatefulWidget {
  /// The initially selected date for the event
  final DateTime initialDate;

  const EventCreationDialog({
    super.key,
    required this.initialDate,
  });

  @override
  State<EventCreationDialog> createState() => _EventCreationDialogState();
}

class _EventCreationDialogState extends State<EventCreationDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _startDate = widget.initialDate;
    _endDate = widget.initialDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              verticalSpace(10),
              Text(
                'Every moment of learning is a step towards success.',
                style: font16Greyregular,
              ),
              verticalSpace(20),
              _buildEventTitleField(),
              verticalSpace(20),
              _buildDateRangeFields(),
              verticalSpace(20),
              _buildDescriptionField(),
              verticalSpace(20),
              _buildFeaturesList(),
              verticalSpace(20),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          'Create Event',
          style: font24BlackBold,
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: ColorsManager.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildEventTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Title',
          style: font16BlackBold,
        ),
        verticalSpace(8),
        _buildTextField(_titleController, 'Event Title'),
      ],
    );
  }

  Widget _buildDateRangeFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Start Date',
                style: font16BlackBold,
              ),
              verticalSpace(8),
              _buildDatePicker(
                context,
                _startDate,
                (date) => setState(() => _startDate = date),
              ),
            ],
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event End Date',
                style: font16BlackBold,
              ),
              verticalSpace(8),
              _buildDatePicker(
                context,
                _endDate,
                (date) => setState(() => _endDate = date),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: font16BlackBold,
        ),
        verticalSpace(8),
        _buildTextField(
          _descriptionController,
          'Type Something Of You Want...',
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildFeaturesList() {
    return Column(
      children: [
        _buildFeatureItem(
          Icons.edit,
          ColorsManager.primaryColor,
          'With every event, we write a new chapter in our learning journey.',
        ),
        verticalSpace(10),
        _buildFeatureItem(
          Icons.lightbulb_outline,
          Colors.amber,
          'Learn, engage, and achieve your dreams with us',
        ),
        verticalSpace(10),
        _buildFeatureItem(
          Icons.school,
          Colors.blue,
          'Let\'s explore the world of knowledge, step by step.',
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return CustomButton(
      text: 'Save',
      onPressed: () async {
        if (_titleController.text.isNotEmpty &&
            _descriptionController.text.isNotEmpty) {
          // Add event logic would go here

          Navigator.pop(context, {
            'title': _titleController.text,
            'description': _descriptionController.text,
            'startDate': _startDate,
            'endDate': _endDate,
          });

          // Show a snackbar to indicate success
        } else {
          AppStates.ErrorToast('Please fill all the fields');
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, DateTime initialDate,
      Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: ColorsManager.primaryColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Text(
              DateFormat('MMM dd, yyyy').format(initialDate),
              style: font16BlackRegular.copyWith(fontSize: 12.r),
            ),
            const Spacer(),
            Icon(
              Icons.calendar_today,
              color: ColorsManager.primaryColor,
              size: 18.r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20.r,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Text(
            text,
            style: font16Greyregular,
          ),
        ),
      ],
    );
  }
}
