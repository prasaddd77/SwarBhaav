import "package:flutter/material.dart";


class NewButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final IconData? icon;

  const NewButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 50),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueGrey[200], // foreground
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 5),
          Text(text, style: TextStyle(color: Colors.black, fontSize: 15)),
        ],
      ),
    );
  }
}
