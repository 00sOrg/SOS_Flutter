import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class WriteChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const WriteChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      visualDensity: VisualDensity.compact,
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.white : AppColors.blue,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: AppColors.blue, width: 1.2),
      ),
      backgroundColor: AppColors.white,
      selectedColor: AppColors.blue,
      onSelected: onSelected,
      checkmarkColor: AppColors.white,
      selected: isSelected,
      // showCheckmark: false,
    );
  }
}
