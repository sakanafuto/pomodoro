// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pomodoro/constant/colors.dart';

ButtonStyle get pomoElevatedButtonStyle {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 24,
    ),
    foregroundColor: textColor,
    elevation: 0,
  );
}
