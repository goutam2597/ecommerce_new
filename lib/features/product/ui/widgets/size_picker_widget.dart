import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });

  final List<String> sizes;
  final Function(String) onSizeSelected;

  @override
  State<SizePickerWidget> createState() => _SizePickerWidgetState();
}

class _SizePickerWidgetState extends State<SizePickerWidget> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _getSizeOfItems()),
    );
  }

  List<Widget> _getSizeOfItems() {
    List<Widget> sizeItemWidgetList = [];
    for (String size in widget.sizes) {
      Widget item = getSizeItemWidget(
        name: size,
        onTap: () {
          setState(() {
            _selectedSize = size;
          });
          widget.onSizeSelected(_selectedSize!);
        },
        isSelected: _selectedSize == size,
      );
      sizeItemWidgetList.add(item);
    }
    return sizeItemWidgetList;
  }

  Widget getSizeItemWidget({
    required String name,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, // Fixed width
        height: 40, // Fixed height
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.themeColor : Colors.grey.shade300,
          ),
          color: isSelected ? AppColors.themeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
