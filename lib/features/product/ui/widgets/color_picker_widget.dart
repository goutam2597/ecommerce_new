import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  final List<String> colors; // Example: ["#FF0000", "#00FF00", "#0000FF"]
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
    return widget.colors.map((color) {
      return _buildColorItem(
        hexColor: color,
        onTap: () {
          setState(() {
            _selectedColor = color;
          });
          widget.onColorSelected(color);
        },
        isSelected: _selectedColor == color,
      );
    }).toList();
  }

  Widget _buildColorItem({
    required String hexColor,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    Color parsedColor = _parseColor(hexColor);

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

  Color _parseColor(String hexColor) {
    String hex = hexColor.toUpperCase().replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex"; // add opacity if not present
    return Color(int.parse(hex, radix: 16));
  }
}
