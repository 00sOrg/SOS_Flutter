import 'package:flutter/material.dart';
import 'package:nearhere/shared/models/location.dart';

class HeaderArea extends StatelessWidget {
  final Location location;

  const HeaderArea({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 46),
        const Text(
          'NERE HERE!',
          style: TextStyle(
            fontFamily: 'Bangers',
            fontSize: 52,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '"',
              style: TextStyle(
                fontFamily: 'Bangers',
                fontSize: 25,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              location.adminAddress,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 6),
            const Text(
              '"',
              style: TextStyle(
                fontFamily: 'Bangers',
                fontSize: 25,
              ),
            ),
          ],
        ),
        const SizedBox(height: 46),
      ],
    );
  }
}