// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomWavyAnimetedText extends StatelessWidget {
  const CustomWavyAnimetedText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayLarge!,
      child: AnimatedTextKit(
        totalRepeatCount: 100,
        animatedTexts: [
          WavyAnimatedText(
            text,
            textStyle: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
