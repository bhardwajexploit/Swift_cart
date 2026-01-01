import 'package:flutter/cupertino.dart';  // ✅ Changed
import '../../core/theme/app_colours.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(  // ✅ Changed
      backgroundColor: AppColours.bG,  // ✅ AppColours
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                  letterSpacing: 1.2,
                ),
                children: const [
                  TextSpan(text: "SwiftCart"),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.white,
                ),
                children: [
                  TextSpan(text: "           "),
                  TextSpan(text: "Get Streetwear instantly"),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // ✅ iOS Loader
            CupertinoActivityIndicator(
              color: CupertinoColors.white.withAlpha(10),
              radius: 18,
            ),
          ],
        ),
      ),
    );
  }
}
