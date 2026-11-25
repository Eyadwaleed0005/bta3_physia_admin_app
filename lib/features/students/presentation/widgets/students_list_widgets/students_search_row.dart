import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/widgets/custom_search_bar.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_filter_button.dart';
import 'package:flutter/material.dart';

class StudentsSearchRow extends StatelessWidget {
  const StudentsSearchRow({
    super.key,
    required this.initialText,
    required this.isFilterActive,
    required this.onQueryChanged,
    required this.onFilterTap,
  });

  final String initialText;
  final bool isFilterActive;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            initialText: initialText,
            hintText: 'ابحث بالاسم أو البريد',
            onChanged: onQueryChanged,
          ),
        ),
        horizontalSpace(10),
        StudentsFilterButton(isActive: isFilterActive, onTap: onFilterTap),
      ],
    );
  }
}
