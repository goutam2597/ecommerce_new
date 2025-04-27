import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  final List<String> colors; // Example: ["red", "green", "blue"]
  final Function(String) onColorSelected;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _buildColorItems()),
    );
  }

  List<Widget> _buildColorItems() {
    return widget.colors.map((colorName) {
      return _buildColorItem(
        colorName: colorName,
        onTap: () {
          setState(() {
            _selectedColor = colorName;
          });
          widget.onColorSelected(colorName);
        },
        isSelected: _selectedColor == colorName,
      );
    }).toList();
  }

  Widget _buildColorItem({
    required String colorName,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    Color parsedColor = _parseColorName(colorName);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: parsedColor,
          border: Border.all(
            color: isSelected ? AppColors.themeColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }

  Color _parseColorName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'brown':
        return Colors.brown;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'cyan':
        return Colors.cyan;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.grey; // fallback color if name not found
    }
  }
}
