import 'package:chat_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WellComeView extends StatelessWidget {
  const WellComeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome to Chat App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/thunder.svg'),
                const SizedBox(width: 10.0),
                const CustomWavyAnimetedText(
                  text: 'Flash Chat',
                ),
              ],
            ),
            CustomElevatedButton(
              text: 'Login',
              onPressed: () {},
            ),
            const SizedBox(height: 20.0),
            CustomElevatedButton(
              text: 'Register',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
