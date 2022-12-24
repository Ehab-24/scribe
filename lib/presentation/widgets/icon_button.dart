import 'package:backend_testing/globals/Constants.dart';
import 'package:backend_testing/presentation/ui%20elements/colors.dart';
import 'package:flutter/material.dart';

const double _iconButtonSize = 47;

class MIconButton extends StatefulWidget {
  const MIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<MIconButton> createState() => _MIconButtonState();
}

class _MIconButtonState extends State<MIconButton> {

  bool isPressed = false;
  final double pressedScale = 0.85;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapCancel: () => _setIsPressed(false),
      onTapUp: (_) => _setIsPressed(false),
      onTapDown: (_) => _setIsPressed(true),
      child: AnimatedScale(
        duration: d200,
        curve: Curves.easeOutQuad,
        scale: isPressed? pressedScale: 1.0,
        child: PhysicalModel(
          elevation: 12.0,
          color: Colors.transparent,
          shadowColor: primaryDark.withOpacity(0.75),
          borderRadius: BorderRadius.circular(_iconButtonSize),
          child: Container(
            width: _iconButtonSize,
            height: _iconButtonSize,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              widget.icon,
              size: 24,
              color: primaryDark,
            ),
          ),
        ),
      ),
    );
  }

  void _setIsPressed(bool val) {
    setState(() {
      isPressed = val;
    });
  }
}
