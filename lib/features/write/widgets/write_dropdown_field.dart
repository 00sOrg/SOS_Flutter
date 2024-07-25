import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nearhere/features/write/viewmodels/write_viewmodel.dart';
import 'package:nearhere/shared/models/category.dart';

class WriteDropdownField extends ConsumerStatefulWidget {
  final WriteViewModel viewModel;

  const WriteDropdownField({super.key, required this.viewModel});

  @override
  _WriteDropdownFieldState createState() => _WriteDropdownFieldState();
}

class _WriteDropdownFieldState extends ConsumerState<WriteDropdownField> {
  CategoryKey? selectedCategory;

  @override
  Widget build(BuildContext context) {
    Category? selectedCategoryData = selectedCategory != null ? getCategory(selectedCategory!) : null;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD6D6D6),
          width: 1,
        ),
        color: selectedCategoryData?.color ?? Colors.white,
        // color: selectedCategory != null ? getCategory(selectedCategory).color : Colors.white
        // color: selectedCategory != null ? getCategory(selectedCategory).color : Colors.white
      ),
      
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CategoryKey>(
          value: selectedCategory,
          hint: const Text(
            '선택',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF343434),
            ),
          ),
          icon: const Icon(
            Icons.unfold_more,
            color: Color(0xFF595959),
            size: 22,
          ),
          items: CategoryKey.values.map((CategoryKey categoryKey) {
            final category = getCategory(categoryKey);
            return DropdownMenuItem<CategoryKey>(
              value: categoryKey,
              child: Row(
                children: [
                  SvgPicture.asset(
                    category.iconPathColored,
                    width: 26,
                    height: 26,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    category.text,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF343434),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (CategoryKey? newValue) {
            setState(() {
              selectedCategory = newValue;
              if(newValue != null){
                widget.viewModel.updateCategory(newValue.toString().split('.').last);
              }
            });
          },
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}