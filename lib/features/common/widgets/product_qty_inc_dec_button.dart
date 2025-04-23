import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductQtyIncDecButton extends StatefulWidget {
  const ProductQtyIncDecButton({super.key, required this.onChanged});

  final Function(int) onChanged;

  @override
  State<ProductQtyIncDecButton> createState() => _ProductQtyIncDecButtonState();
}

class _ProductQtyIncDecButtonState extends State<ProductQtyIncDecButton> {
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(
          icon: Icons.remove,
          onTap: () {
            if (_count > 1) {
              _count--;
              widget.onChanged(_count);
              setState(() {});
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$_count',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        _buildIconButton(
          icon: Icons.add,
          onTap: () {
            if (_count < 20) {
              _count++;
              widget.onChanged(_count);
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
