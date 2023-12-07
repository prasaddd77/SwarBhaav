import "package:flutter/material.dart";

import "animated_counter.dart";

class BoxedContainer extends StatelessWidget {
  final String title;
  final int val;
  final IconData icon;
  const BoxedContainer({
    super.key,
    required this.title,
    required this.val,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        // boxShadow: const [
        //   BoxShadow(
        //       offset: Offset(0, 0),
        //       blurRadius: 2,
        //       spreadRadius: 2,
        //       color: Colors.white54),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: Colors.black),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          AnimatedCounter(value: val),
        ],
      ),
    );
  }
}
