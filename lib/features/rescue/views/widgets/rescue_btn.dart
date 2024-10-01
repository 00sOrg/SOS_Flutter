import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class RescueBtn extends StatefulWidget {
  final double radius;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const RescueBtn({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.radius,
  });

  @override
  State<RescueBtn> createState() => _RescueBtnState();
}

class _RescueBtnState extends State<RescueBtn> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
        child: Container(
          width: double.infinity,
          height: 106,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.color,
            boxShadow: [
              BoxShadow(
                offset: const Offset(3, 3),
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 4,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 24,
              height: 1.2,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}


// class RescueBtn extends StatelessWidget {
//   final String text;
//   final Color color;
//   final VoidCallback onTap;

//   const RescueBtn({
//     super.key,
//     required this.text,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: 108,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: color,
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(3, 3),
//               color: AppColors.black.withOpacity(0.25),
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 24,
//             height: 1.2,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFFFFFFFF),
//           ),
//         ),
//       ),
//     );
//   }
// }
