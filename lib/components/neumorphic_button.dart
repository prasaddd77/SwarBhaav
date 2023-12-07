import "package:flutter/material.dart";
import "package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart" as ibs;

class NeumorphismButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Icon icon;
  const NeumorphismButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    Offset distance = _isPressed ? const Offset(10, 10) : const Offset(28, 28);
    double blur = _isPressed ? 5.0 : 30.0;
    return Center(
      child: GestureDetector(
        onTap: () => setState(() {
          _isPressed = !_isPressed;
          widget.onPressed();
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: ibs.BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey[100],
            boxShadow: [
              ibs.BoxShadow(
                blurRadius: blur,
                offset: distance,
                color: const Color(0xFFA7A9AF),
                inset: _isPressed,
              ),
              ibs.BoxShadow(
                blurRadius: blur,
                offset: -distance,
                color: Colors.white,
                inset: _isPressed,
              ),
            ],
          ),
          child: SizedBox(
            height: 90,
            width: 300,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon,
                  const SizedBox(width: 5),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
